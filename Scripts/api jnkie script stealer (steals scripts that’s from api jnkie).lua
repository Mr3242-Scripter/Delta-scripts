getgenv().SCRIPT_KEY = "KEYLESS"

local key = getgenv().SCRIPT_KEY or SCRIPT_KEY
local request = (type(syn) == "table" and type(syn.request) == "function" and syn.request)
    or (type(request) == "function" and request)
    or (type(http_request) == "function" and http_request)
    or (type(http) == "table" and type(http.request) == "function" and http.request)

if type(key) ~= "string" then
    warn("Key verification failed")
    return
end

if type(request) ~= "function" then
    warn("No HTTP request function available")
    return
end

local function doRequest(options)
    local finished = false
    local success, response

    task.spawn(function()
        success, response = pcall(request, options)
        finished = true
    end)

    local start = os.clock()

    repeat
        task.wait()
    until finished or os.clock() - start > 15

    if not finished then
        return false, nil
    end

    return success, response
end

-- Step 1: send the script key
local success, response = doRequest({
    Url = "api jnkie link here",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "text/plain"
    },
    Body = key
})

if not success or type(response) ~= "table" then
    warn("Delivery request failed")
    return
end

-- Step 2: handle the CDN URL returned by the server
if response.StatusCode == 200
    and type(response.Body) == "string"
    and response.Body:sub(1, 22) == "https://cdn.jnkie.com/" then

    success, response = doRequest({
        Url = response.Body,
        Method = "GET"
    })
end

-- Step 3: handle redirects
if success
    and type(response) == "table"
    and (response.StatusCode == 302 or response.StatusCode == 303) then

    local headers = response.Headers or response.headers
    local location = type(headers) == "table"
        and (headers.Location or headers.location)

    if type(location) == "string"
        and location:sub(1, 22) == "https://cdn.jnkie.com/" then

        success, response = doRequest({
            Url = location,
            Method = "GET"
        })
    end
end

-- Step 4: copy the final response instead of executing it
if not success
    or type(response) ~= "table"
    or response.StatusCode ~= 200
    or type(response.Body) ~= "string"
    or #response.Body == 0 then

    warn("Failed to download final script")
    return
end

setclipboard(response.Body)
print("Final downloaded script copied to clipboard.")