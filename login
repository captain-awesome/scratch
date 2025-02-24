# Tidal API Credentials
$USERNAME = "jack"
$PASSWORD = "password123"

# Tidal API Base URL (Replace with your actual API URL)
$API_URL = "https://blah.com:8080"

# Authentication Endpoint
$AUTH_URL = "$API_URL/auth/login"

# Prepare the JSON body for authentication
$authBody = @{
    username = $USERNAME
    password = $PASSWORD
} | ConvertTo-Json -Compress

# Attempt to log in and get the authentication token
try {
    $authResponse = Invoke-RestMethod -Uri $AUTH_URL -Method Post -ContentType "application/json" -Body $authBody

    # Check if a token is received
    if ($authResponse.token) {
        Write-Host "Login Successful! Token: $($authResponse.token)"
    } else {
        Write-Host "Login failed. No token received."
    }
} catch {
    Write-Host "Error: Unable to authenticate. Check your API URL, credentials, or network connection."
    Write-Host "Error Details: $_"
}
