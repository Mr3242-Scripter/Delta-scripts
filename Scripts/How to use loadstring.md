# How Raw Script URLs Work

This guide explains how to find the plain-text source URL for a script hosted on Pastebin or GitHub, how to check that the link returns source code, and what to review before trusting the contents.

It focuses on locating and inspecting source files. A raw link is simply a way to view text; it does not verify the code or make it safe.

## 1. What is a raw URL?

A normal hosting-page URL usually displays a webpage with buttons, formatting, navigation, and a code preview.

A raw URL returns the file's contents as plain text. This is useful when you want to inspect or copy the original source without the surrounding webpage.

## 2. Finding a Pastebin raw URL

1. Open the paste's normal webpage.
2. Find and select its **Raw** option.
3. Check that the page now displays only the text of the paste.
4. Copy the address from the browser.
5. Open the copied address in a new tab and confirm that it shows the expected source text.

A common Pastebin raw URL has this format: `https://pastebin.com/raw/PASTE_ID`

Replace `PASTE_ID` with the identifier from the paste's URL. The raw endpoint returns the stored text rather than the normal viewing page. Some pastes may be private, protected, expired, or unavailable as raw text.

## 3. Finding a raw GitHub file URL

1. Open the repository on GitHub.
2. Navigate to the file you want to inspect.
3. Select **Raw**.
4. Confirm that the browser displays the file's plain text.
5. Copy the URL only after checking that it points to the correct repository, branch, and file.

A GitHub raw URL generally follows this structure: `https://raw.githubusercontent.com/OWNER/REPOSITORY/BRANCH/PATH`

For this repository, script filenames are extensionless. Keep the exact filename and path shown on GitHub; do not add `.lua` if the file does not have that suffix.

Example structure for a file in this repository: `https://raw.githubusercontent.com/Mr3242-Scripter/Delta-scripts/main/Scripts/FILE_NAME`

Replace `FILE_NAME` with the exact filename. If the filename contains spaces, the URL must encode those spaces as `%20`.

## 4. How to check that a link is correct

Before relying on a raw URL:

- Open it in a browser.
- Confirm that it displays source text rather than an HTML webpage.
- Check the owner, repository, branch, and filename carefully.
- Confirm that the content matches the script you intended to inspect.
- If the page shows an error, check whether the file was renamed, moved, deleted, or whether the branch name is correct.

A raw URL can stop working if the file is moved, renamed, deleted, or the hosting service changes its access rules.

## 5. Inspect the source before trusting it

Read the entire file and look for:

- Unexpected network requests or remote code downloads.
- Obfuscated or heavily encoded sections that make the behavior difficult to understand.
- Requests for passwords, account credentials, private tokens, or other sensitive information.
- Code that changes settings or game state in ways the description does not explain.
- Dependencies on specific games, APIs, or environments.

Do not assume a script is safe just because it is hosted on GitHub or Pastebin. Anyone with permission to edit a hosted file may be able to change what its raw URL returns later.

## 6. How to execute the script once you have the raw link (Very Easy Steps)

Once you have a working raw URL, follow these simple steps to run the script with **your executor** (Delta is recommended):

### Step 1 – Create the loadstring
Copy this exact format and replace the URL:

```lua
loadstring(game:HttpGet("YOUR_RAW_URL_HERE"))()
```

**Real example** (using a file from this repository):
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Mr3242-Scripter/Delta-scripts/main/Scripts/Your%20Script%20Name"))()
```

Make sure you keep the final `()` at the end. Do not remove it.

### Step 2 – Copy the full loadstring
Select the entire line (from `loadstring` all the way to the last `()`) and copy it.

### Step 3 – Open your executor and join the correct game
- Open the executor you are using (for example Delta)
- Join the Roblox game that the script is made for

**Don’t have an executor yet?**  
You can easily download the official **Delta Executor** from these official links only:
- https://deltaexploits.gg
- https://deltaexploits.dev

### Step 4 – Paste the script into your executor
1. Open your executor
2. Paste the loadstring into the script editor (or use the "Add Script" / "Execute Clipboard" button if your version has it)
3. Attach / Inject if your executor asks you to

### Step 5 – Execute
Press the **Execute** button.

If everything is correct, the script should start running and its GUI (if it has one) should appear.

### Quick Tips
- Always open the raw URL in your browser first and quickly check the code.
- If you get a 404 error, the file was moved, renamed, or the URL is wrong.
- Keep spaces encoded as `%20`.
- Some scripts need to be executed again after you rejoin the game.
- Make sure you are in the right game before executing.

That’s it! Once you have the raw link, just wrap it in the loadstring and execute it in your executor.

## 7. Common problems

### The raw link shows a webpage

You copied the normal viewing URL. Return to the hosting page and select its **Raw** option.

### The link returns Not Found

Check the file path, branch, spelling, and capitalization. For GitHub files in this repository, remember that names are extensionless.

### The text is different from what you expected

The file may have been updated. Compare it with the version you previously reviewed before trusting it.

### The paste is unavailable

It may have expired, been deleted, or have access restrictions that prevent raw viewing.

## 8. Useful links

- [Delta Scripts repository](https://github.com/Mr3242-Scripter/Delta-scripts)
- [Scripts folder](https://github.com/Mr3242-Scripter/Delta-scripts/tree/main/Scripts)
- [GitHub documentation: viewing and understanding files](https://docs.github.com/en/repositories/working-with-files/using-files)
- [Pastebin raw URL overview](https://www.fortinet.com/resources/articles/pastebin)

**Remember:** A raw URL gives you the source text. Always inspect that text and verify its origin before deciding whether to trust it.
