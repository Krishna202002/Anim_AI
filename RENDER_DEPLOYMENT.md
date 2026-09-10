# 🚀 Deploying AnimAI Studio on Render

This guide provides step-by-step instructions to deploy **AnimAI Studio** on [Render](https://render.com) so you can showcase a live, working AI system in technical interviews and on your resume/portfolio.

---

## 🛠️ Architecture Summary

AnimAI Studio runs as a **Docker Web Service** on Render. 
- **Frontend & App Logic**: Streamlit
- **LLM Engine**: Google Gemini API (`gemini-2.5-flash`) via `google-genai`
- **Animation Renderer**: Manim Community Edition + FFmpeg + Voiceover (gTTS) inside Docker
- **RAG Engine**: FAISS + Sentence Transformers (`all-MiniLM-L6-v2`)

---

## 📥 Step 1: Push Code to GitHub

Ensure your project code is committed and pushed to a GitHub repository.

```bash
# Navigate to project directory
cd c:\python\miniProject\AnimAi

# Check git status
git status

# Add files and commit
git add .
git commit -m "Prepare AnimAI Studio for Render Docker deployment"

# Push to your GitHub repo
git push origin main
```

*(If you haven't created a GitHub repository yet, create a new public repository on [github.com](https://github.com/new) and follow the instructions to push your local repository).*

---

## ☁️ Step 2: Deploy on Render

### Option A: 1-Click Blueprint Deployment (Recommended)

1. Sign in to [Render](https://dashboard.render.com/).
2. Click the **New +** button at the top right and select **Blueprint**.
3. Connect your GitHub account and select your **AnimAI Studio** repository.
4. Render will automatically detect `render.yaml`.
5. Under **Environment Variables**, fill in your `GEMINI_API_KEY` ([get a key here](https://aistudio.google.com/app/apikey)).
6. Click **Apply**. Render will automatically build the Docker image and deploy your service!

---

### Option B: Manual Web Service Deployment

1. Sign in to [Render](https://dashboard.render.com/).
2. Click **New +** -> **Web Service**.
3. Select **Build and deploy from a Git repository** and pick your repository.
4. Fill in the following details:
   - **Name**: `animai-studio` (or any custom name)
   - **Language / Environment**: `Docker`
   - **Branch**: `main`
   - **Dockerfile Path**: `./Dockerfile`
   - **Instance Type**: `Free`
5. Expand **Advanced / Environment Variables** and add:
   | Key | Value |
   |---|---|
   | `GEMINI_API_KEY` | `your_actual_gemini_api_key_here` |
   | `GEMINI_MODEL` | `gemini-2.5-flash` |
   | `RENDER` | `true` |
6. Click **Create Web Service**.

---

## ⏱️ Step 3: Deployment Verification

1. Render will take ~3–6 minutes for the initial Docker build (installing Manim, TeX dependencies, Python libraries, and RAG index).
2. Once the log says `Your service is live 🎉`, click the URL provided by Render (e.g. `https://animai-studio.onrender.com`).
3. Test a prompt like:
   `"Animate bubble sort with array 5 2 8 1 9"`
4. Verify that the video preview and narration render successfully!

---

## 💼 How to Showcase in Interviews

When showcasing AnimAI Studio in tech interviews or on your resume:

### 1. Resume / Portfolio Link Format
> **AnimAI Studio — Autonomous AI Educational Video Generator** | [Live Demo](https://animai-studio.onrender.com) | [GitHub](https://github.com/yourusername/animai-studio)
> - Built a multi-agent orchestration framework (Planner, Coder, Self-Healing Debugger) powered by Gemini LLM.
> - Containerized rendering pipeline using Docker & Manim to dynamically generate Python animations with synchronized voiceovers.
> - Integrated RAG using FAISS & Sentence Transformers to retrieve relevant code patterns for complex visual concepts.

### 2. Interview Talking Points
- **System Architecture**: Explain the pipeline (Planner creates structural JSON → Coder generates Manim script → Sandbox runs code → Debugger catches syntax/runtime errors and retries automatically up to 3 times).
- **RAG Integration**: Describe how FAISS vector search retrieves relevant Manim patterns to guide LLM code generation.
- **Production Containerization**: Explain why Docker was used (encapsulating TeX, FFmpeg, SoX, and Python dependencies) and how subprocess execution was optimized for cloud deployment.
- **Feedback & Learning Loop**: Mention how user feedback (thumbs up/down and post-generation revision loop) allows continuous system refinement.
