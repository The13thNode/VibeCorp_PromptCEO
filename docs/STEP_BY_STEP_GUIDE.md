# Step-by-Step Guide — PromptCEO

> This guide assumes you have never used a terminal, GitHub, or Claude Code before.
> Follow each step exactly. Do not skip ahead.

## What You Need

- A computer (Windows, Mac, or Linux)
- An internet connection
- A Claude subscription (Pro at $20/month minimum, Max at $100-200/month recommended)

## What You Do NOT Need

- Programming experience
- A GitHub account (we'll create one)
- Any special software pre-installed
- A business plan (a rough idea is enough)

---

### Step 1: What is Claude Code?

**Before you start:** This step explains what Claude Code is and gets it installed on your computer. You will need to install Node.js first (a free piece of software), then install Claude Code through your terminal. This takes about 5-10 minutes.

Claude Code is a command-line tool made by Anthropic — the same company that makes the Claude chatbot. It is different from the Claude.ai website you may have used before.

Here is the easiest way to think about the difference:

- **Claude.ai chat** = texting a smart friend who can answer questions
- **Claude Code** = hiring that friend to sit at your desk, open your files, read them, write code, run programs, and actually get things done

Claude Code can read files on your computer, write and edit code, run commands, and connect to external tools like Slack, Jira, and Notion. That is why it is so much more powerful than the browser chat.

Official docs: [Claude Code Documentation](https://code.claude.com/docs)

**How to install Claude Code:**

**On Windows:**

1. Go to https://nodejs.org and click the large green "LTS" download button. Run the installer. Click Next through all the defaults.
2. Press the Windows key, type "Terminal" or "PowerShell", and press Enter to open your terminal.
3. In the terminal, type the following and press Enter:
   ```
   npm install -g @anthropic-ai/claude-code
   ```
4. Wait for it to finish. You will see a lot of text scroll by — that is normal.
5. Type this and press Enter to confirm it worked:
   ```
   claude --version
   ```
   You should see a version number like `1.x.x`. If you do, you are ready.

**On Mac:**

1. Go to https://nodejs.org and click the large green "LTS" download button. Open the downloaded file and follow the installer.
2. Press Cmd+Space, type "Terminal", and press Enter.
3. In the terminal, type the following and press Enter:
   ```
   npm install -g @anthropic-ai/claude-code
   ```
4. Wait for it to finish.
5. Verify it worked:
   ```
   claude --version
   ```

**Troubleshooting Step 1:**
- If you see "npm: command not found" — Node.js did not install correctly. Go back and re-run the Node.js installer from https://nodejs.org, then restart your terminal.
- If you see "permission denied" — On Mac/Linux, put `sudo` in front of the command: `sudo npm install -g @anthropic-ai/claude-code`. It will ask for your Mac login password.

---

### Step 2: What is GitHub?

**Before you start:** GitHub is the website where this framework lives. You will create a free account and then download (clone) the PromptCEO files to your computer. This takes about 5 minutes.

GitHub is a website that stores code. Think of it as Google Drive, but designed specifically for code files. Millions of developers use it to share projects for free.

You need GitHub to download this framework. Here is how:

**Create a free GitHub account:**

1. Go to https://github.com/join
2. Enter a username, email address, and password
3. Verify your email when GitHub sends you a confirmation

**Download (clone) this framework to your computer:**

Once you have your account, open your terminal (see Step 3 if you have not done this yet) and type:

```bash
git clone https://github.com/The13thNode/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO
```

What those commands mean:
- `git clone` = download a copy of the project to your computer
- `cd VibeCorp_PromptCEO` = open that folder (cd stands for "change directory")

After running these two commands, you will have a folder called `VibeCorp_PromptCEO` on your computer with all the files inside it.

**Troubleshooting Step 2:**
- If you see "git: command not found" — Git is not installed. Go to https://git-scm.com/downloads, download Git for your operating system, install it, and then restart your terminal. Try the commands again.
- If the download seems to hang — check your internet connection and try again.

---

### Step 3: What is a Terminal?

**Before you start:** The terminal is already on your computer. You do not need to install anything. This step just shows you how to open it. It looks intimidating at first — a blank screen with a blinking cursor — but you will only ever be typing simple commands.

The terminal is a text-based way to talk to your computer. Instead of clicking buttons and icons, you type commands and press Enter.

**How to open the terminal:**

**Windows:**
1. Press the Windows key on your keyboard
2. Type "Terminal" or "PowerShell"
3. Press Enter

**Mac:**
1. Press Cmd+Space (this opens Spotlight Search)
2. Type "Terminal"
3. Press Enter

**Linux:**
1. Press Ctrl+Alt+T
2. A terminal window will open immediately

**What you will see:** A mostly blank screen with some text and a blinking cursor. That is completely normal. The terminal is waiting for you to type a command. You are not breaking anything by looking at it.

**Basic terminal tip:** After typing any command, always press Enter to run it. If you make a typo, press Ctrl+C to cancel and start over.

---

### Step 4: Fill in Your Project Details

**Before you start:** This is where you personalize the framework for your project. You will open one file, find the placeholder text, and replace it with your actual project information. No coding required — this is just editing a text file. Takes about 10-15 minutes.

The file `CLAUDE.md` is the brain of the framework. It tells Claude Code everything about your project — what it is, who is building it, what tools you use, what the agents should do. You need to fill it in before the agents will work properly.

**How to do it:**

1. Open your file explorer (Windows Explorer or Mac Finder)
2. Navigate to the `VibeCorp_PromptCEO` folder you downloaded in Step 2
3. Find the file called `CLAUDE.md`
4. Open it in any text editor:
   - **Windows:** Right-click the file, choose "Open with", select Notepad (or VS Code if you have it)
   - **Mac:** Right-click the file, choose "Open with", select TextEdit (or VS Code if you have it)
5. Look through the file for text that looks like `[PROJECT_NAME]`, `[TECH_STACK]`, `[FOUNDER_NAME]`, etc. These are placeholders surrounded by square brackets.
6. Replace each one with your actual information:
   - `[PROJECT_NAME]` → the name of your project, e.g. `MyApp`
   - `[FOUNDER_NAME]` → your name
   - `[TECH_STACK]` → what you are building with, e.g. `React, Node.js` or just `no-code tools` if you are not sure
7. Save the file (Ctrl+S on Windows, Cmd+S on Mac)

**Not sure what to put?** Open the file `examples/blank-saas/CLAUDE.md.example` — it shows a realistic filled-in version of the same file so you can see how it should look.

**Tip:** You do not need to fill in every single field perfectly right now. Put your best guess. You can always edit the file again later.

---

### Step 5: (Optional) Configure Integrations

**Before you start:** This step is optional. Skip it if you just want to try the agents first. You can always come back to this later. Integrations connect Claude Code to external tools like Slack, Jira, and Notion.

You do NOT need integrations to use the agents. The agents work without them. Integrations just let Claude Code send messages to your Slack, create Jira tickets, or update your Notion workspace automatically.

**If you want to set up integrations:**

1. In the `VibeCorp_PromptCEO` folder, find the file `templates/mcp.example.json`
2. Copy that file and rename the copy to `.mcp.json` (note the dot at the start — that is intentional)
3. Put the `.mcp.json` file in the main `VibeCorp_PromptCEO` folder (the root)
4. Open `.mcp.json` in a text editor and fill in your API keys for the integrations you want

For detailed instructions on each integration, see `SETUP.md` in the main folder.

**Troubleshooting Step 5:**
- If you cannot see `.mcp.json` after creating it — files starting with a dot are hidden by default. On Windows, in File Explorer, click View and check "Hidden items". On Mac, press Cmd+Shift+. to show hidden files.

---

### Step 6: Test Your First Agent

**Before you start:** This is the fun part. You will start Claude Code, point it at this project, and watch the CEO agent introduce itself and explain what it can do. This should take under 5 minutes once Claude Code is running.

1. Open your terminal (see Step 3 if you forgot how)
2. Navigate to the project folder by typing:
   ```
   cd path/to/VibeCorp_PromptCEO
   ```
   Replace `path/to/` with the actual location of the folder on your computer. For example:
   - Windows: `cd Desktop\VibeCorp_PromptCEO`
   - Mac/Linux: `cd ~/Desktop/VibeCorp_PromptCEO`

   The exact path depends on where you ran `git clone`. If you ran it from your Desktop, the above will work.

   On Mac it might also be:
   ```
   cd /Users/YourName/VibeCorp_PromptCEO
   ```
3. Start Claude Code by typing:
   ```
   claude
   ```
4. You will see Claude Code start up. Type this message and press Enter:
   ```
   Read CLAUDE.md and begin session start ritual
   ```
5. Claude will read your project context and start operating as the CEO orchestrator agent.

**Try asking it:**
```
What agents do I have available? Summarize their roles.
```

**What to expect:** Claude will respond with a summary of the 13 agents in the framework and ask what you want to work on. It may ask you a few clarifying questions about your project before it starts. That is normal — it is trying to understand your context.

**Troubleshooting Step 6:**
- If Claude seems confused — make sure you filled in `CLAUDE.md` properly in Step 4. The more detail you gave it, the better it will perform.
- If nothing happens after you type your message — press Enter. Claude Code waits for Enter before it processes your input.

---

### Step 7: What To Do When Things Go Wrong

Things will occasionally go wrong. That is normal and expected. Here are the most common problems and exactly what to do about them.

**1. "Command not found: claude"**
Claude Code is not installed, or your terminal does not know where to find it. Go back to Step 1 and follow the installation instructions again. After installing, close your terminal completely, reopen it, and try again.

**2. "Permission denied"**
Your computer is blocking the command.
- **Mac/Linux:** Put `sudo` in front of the command. Example: `sudo claude`. It will ask for your login password.
- **Windows:** Close your terminal. Find "Terminal" or "PowerShell" in the Start menu, right-click it, and choose "Run as Administrator". Then try the command again.

**3. "Agent seems stuck" (no response for more than 60 seconds)**
Press Ctrl+C to stop the current session. This will not delete any files. Type `claude` again to start a fresh session. This usually fixes it.

**4. "Agent made a mistake and I want to undo it"**
If Claude Code edited files you did not want changed, you can undo everything with:
```
git checkout .
```
This reverts all unsaved changes back to the last saved state. Use this carefully — it cannot be undone.

If you want to save the changes for later instead of throwing them away:
```
git stash
```
This puts the changes in a holding area. You can bring them back later with `git stash pop`.

**5. "I ran out of tokens" or usage limit error**
Your monthly Claude usage limit was reached. You have two options:
- Wait for your billing cycle to reset (usually the first of the month)
- Upgrade your Claude plan at https://claude.ai/settings/billing

The Max plan ($100-200/month) is recommended for heavy agent usage. The Pro plan ($20/month) works for lighter use but will run out faster when running multiple agents.

---

## Further Reading

These resources will help you go deeper once you are comfortable with the basics:

- [Claude Code Documentation](https://code.claude.com/docs) — Official docs from Anthropic covering all Claude Code features and commands
- [Using Skills in Claude](https://support.claude.com/en/articles/12512180-use-skills-in-claude) — Anthropic support article on how skills work
- [Complete Guide to Building Skills for Claude](https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf) — Anthropic PDF guide for creating your own agent skills
- [Claude Guides: Code, Cowork, Skills, Workflows](https://karozieminski.substack.com/p/claude-guides-code-cowork-skills-workflows) — Karo Zieminski's practical guide covering multiple Claude tools together
- [Skill Creator Reference](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md) — Anthropic's official skill creator reference on GitHub
- [Awesome Agent Skills](https://github.com/VoltAgent/awesome-agent-skills) — Community-curated collection of agent skills by VoltAgent
- [Awesome Claude Skills](https://github.com/ComposioHQ/awesome-claude-skills) — Community-curated collection of Claude skills by ComposioHQ
