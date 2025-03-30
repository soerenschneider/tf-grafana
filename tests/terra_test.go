package test

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const (
	grafanaUrl = "http://localhost:3000"
	vaultUrl   = "http://localhost:8200"
	vaultToken = "test"
)

func TestTerragrunt(t *testing.T) {
	workDir := "../envs/dev"
	dockerOpts := &docker.Options{
		WorkingDir: workDir,
		EnvVars: map[string]string{
			"COMPOSE_FILE": "docker-compose.yaml",
		},
	}

	_ = os.Remove(workDir + "/terraform.tfstate")

	defer docker.RunDockerCompose(t, dockerOpts, "down")
	docker.RunDockerCompose(t, dockerOpts, "up", "-d")

	waitForHttp(t, vaultUrl+"/ui/")
	waitForHttp(t, grafanaUrl)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    workDir,
		TerraformBinary: "terragrunt",
		EnvVars: map[string]string{
			"TF_ENCRYPTION": `key_provider "pbkdf2" "mykey" {passphrase = "somekeynotverysecure"}`,
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	secret, err := readVaultSecret(vaultUrl, vaultToken, "secret/data/env/dev/grafana/serviceaccount/testcase")
	assert.NoError(t, err)
	assert.Contains(t, secret, "token")

	apiURL := fmt.Sprintf("%s/api/search?type=dash-db", grafanaUrl)

	dashboards, err := listGrafanaDashboards(apiURL, secret["token"].(string))
	assert.NoError(t, err)
	assert.Greater(t, len(dashboards), 0)
}

func readVaultSecret(vaultAddr, token, secretPath string) (map[string]interface{}, error) {
	url := fmt.Sprintf("%s/v1/%s", vaultAddr, secretPath)

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %v", err)
	}

	req.Header.Set("X-Vault-Token", token)
	client := &http.Client{
		Timeout: 1 * time.Second,
	}
	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected response status: %s", resp.Status)
	}
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response body: %v", err)
	}

	var responseData map[string]interface{}
	if err := json.Unmarshal(body, &responseData); err != nil {
		return nil, fmt.Errorf("failed to parse JSON response: %v", err)
	}

	data, ok := responseData["data"].(map[string]interface{})
	if !ok {
		return nil, fmt.Errorf("unexpected response structure")
	}

	secretData, ok := data["data"].(map[string]interface{})
	if !ok {
		return nil, fmt.Errorf("unexpected secret data structure")
	}

	return secretData, nil
}

type Dashboard struct {
	Id    int    `json:"id"`
	Title string `json:"title"`
	Uri   string `json:"uri"`
}

func listGrafanaDashboards(apiURL string, apiKey string) ([]Dashboard, error) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", apiURL, nil)
	if err != nil {
		return nil, err
	}

	req.Header.Set("Accept", "application/json")
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", apiKey))

	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected response status: %d", resp.StatusCode)
	}

	var dashboards []Dashboard
	err = json.NewDecoder(resp.Body).Decode(&dashboards)
	if err != nil {
		return nil, err
	}

	return dashboards, nil
}

func waitForHttp(t *testing.T, addr string) {
	retry.DoWithRetry(t, "Waiting for http service", 45, 1*time.Second, func() (string, error) {
		resp, err := http.Get(addr)
		if err != nil {
			return "", err
		}
		defer resp.Body.Close()

		if resp.StatusCode != 200 {
			return "", fmt.Errorf("expected HTTP status 200 but got %d", resp.StatusCode)
		}

		return fmt.Sprintf("Service at %s is available", addr), nil
	})
}
