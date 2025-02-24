# Tidal API Credentials
$USERNAME = "jack"
$PASSWORD = "password123"

# API Endpoint (Replace with actual Tidal API URL)
$API_URL = "https://your-tidal-api-endpoint.com"

# Job Name
$JOB_NAME = "EDP_EDM_EDW_BASE_UNMASK_PRIOR_AUTH_SNAPSHOT"

# Date of Execution
$EXEC_DATE = "2025-02-10"

# Authenticate and obtain a session token
$authBody = @{
    username = $USERNAME
    password = $PASSWORD
} | ConvertTo-Json -Compress

$authResponse = Invoke-RestMethod -Uri "$API_URL/auth/login" -Method Post -ContentType "application/json" -Body $authBody

if (-not $authResponse.token) {
    Write-Host "Authentication failed. Please check your credentials."
    exit
}

$TOKEN = $authResponse.token

# Fetch job execution details
$headers = @{
    "Authorization" = "Bearer $TOKEN"
    "Content-Type"  = "application/json"
}

$jobResponse = Invoke-RestMethod -Uri "$API_URL/jobs/runs?jobName=$JOB_NAME&executionDate=$EXEC_DATE" -Method Get -Headers $headers

if ($jobResponse.runs.Count -eq 0) {
    Write-Host "No run_id found for job: $JOB_NAME on $EXEC_DATE"
} else {
    $RUN_ID = $jobResponse.runs[0].run_id
    Write-Host "Run ID for job $JOB_NAME on $EXEC_DATE: $RUN_ID"
}
