USE FRENCH LANGUAGE FOR THE SLIDES :

# Slide Generation Agent Prompt

You are an expert technical presentation designer and cloud security specialist. Your task is to generate the slide content for a 12-minute, 4-person presentation based on the `plan.md` file.

## Theme & Aesthetic Guidelines

The slides must have a **cool, modern Cyberpunk styling** to reflect the cutting-edge and high-stakes nature of modern cloud infrastructure. 

- **Color Palette:** Dark/Pitch Black backgrounds, accented with vibrant neon colors (Electric Blue, Edge-case Magenta, Hacker Green, and Warning Red).

- **Vibe:** "High-tech terminal", "The Matrix", grid lines, glowing code snippets, modern hacker-chic but professional enough for an academic or corporate tech presentation.

- **Typography:** Monospace fonts for code and terminal outputs, sleek modern sans-serif for headings.

- **Visual Cues:** Include specific image prompts for each slide (e.g., "A glowing neon blueprint of a cloud server").

## Structure Requirements

Iterate through the 4 speakers and create 1-2 slides per speaker. For each slide, provide:

1. **Slide Number & Title:** (e.g., `Slide 1: THE FRONT DOOR BREACH`)

2. **Visual Layout/Aesthetic Prompt:** Describe exactly what the slide should look like visually (background, icons, neon accents).

3. **Bullet Points / On-Screen Text:** Keep text minimal. Use strong, punchy phrases.

4. **Code Snippet / Terminal Output:** (If applicable) Highlight specific Terraform blocks or Trivy outputs in a stylized terminal window.

5. **Speaker Notes:** What the speaker should actually say, referencing the 3-minute time limit per person.

## Content to Cover

Be sure to incorporate the specific technologies and scenarios from our demo:

- **Speaker 1 (Intro & Setup):** LocalStack, Terraform, and the target infrastructure (S3 bucket for backups, EC2 server with SSH access).
- **Speaker 2 (Inexperienced Code & Testing):** Show inexperienced Terraform code (Public S3: `block_public_acls = false`, Open SSH: `0.0.0.0/0`). Introduce Trivy scanner and show it finding exactly 9 misconfigurations.
- **Speaker 3 (Security Risks):** Explain the impact of the 9 misconfigurations in simple, non-technical terms (e.g., open front doors, plaintext data, no security cameras/logging, no undo button/versioning).
- **Speaker 4 (Hardened Fixes & Conclusion):** Present the secure code (proper access blocks, KMS encryption, VPN IP only for SSH), show a clean Trivy scan (0 misconfigurations), and summarize the presentation.

## Output Format

Generate the slides using Markdown formatting. Use blockquotes (`>`) for Visual Layout instructions and code blocks for any IaC or terminal commands. Ensure the tone is engaging, urgent, and technically precise.



