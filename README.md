# Misinformation Propagation Analyzer

A web-based tool to analyze comment sections of social media posts, identify key users in the conversation, and understand how information (and misinformation) propagates through user interactions.

---

## Table of Contents
- [Overview](#overview)
- [Key Features](#key-features)
- [How It Works](#how-it-works)
- [Technology Stack](#technology-stack)
- [Setup and Installation](#setup-and-installation)
- [How to Run](#how-to-run)
- [Understanding the Results](#understanding-the-results)
- [Future Improvements](#future-improvements)

---

## Overview

In the age of social media, information and misinformation spread like wildfire. Understanding the dynamics of this spread is crucial. This tool provides a simple yet powerful way to analyze the propagation network within a social media post's comment section.

By providing a post URL, the application fetches all comments, constructs a user interaction graph, and performs network and sentiment analysis to reveal:
- Who are the most influential "Spreaders" of information?
- Who are the critical "Bridges" connecting different conversation groups?
- What is the relationship between the sentiment of a comment and its ability to engage others?

This project was developed as part of a project at IIT Bhubaneswar.

## Key Features

- **User Interaction Network:** Automatically builds a directed graph from comment reply chains.
- **Centrality Analysis:** Identifies key users using standard network science metrics:
  - **In-Degree Centrality** to find "Spreaders" (users who receive the most replies).
  - **Betweenness Centrality** to find "Bridges" (users connecting disparate conversation clusters).
- **Sentiment Analysis:** Uses state-of-the-art transformer models from Hugging Face to assign a sentiment (positive, negative, neutral) to each comment.
- **Correlation Analysis:** Links comment sentiment to the influence of its author.
- **Web Interface:** A clean, simple UI to input a post URL and view the analysis results.

## How It Works

1.  **Data Collection:** The user submits a URL to a social media post. The Python backend uses an API (e.g., PRAW for Reddit) to fetch the post's title and all associated comments.
2.  **Network Construction:** A directed graph is built using the `networkx` library. Each unique `author` is a node. A directed edge is created from user `A` to user `B` if `B` replies to `A`'s comment.
3.  **Network Analysis:**
    -   **Spreaders (In-Degree):** The in-degree for each node (user) is calculated. A high in-degree means a user's comments receive many direct replies, making them a focal point of engagement.
    -   **Bridges (Betweenness):** Betweenness centrality is calculated for each node. A high score indicates that a user lies on many of the shortest paths between other pairs of users, acting as a crucial link between different parts of the conversation.
4.  **Sentiment Analysis:** The sentiment of each comment is analyzed using a pre-trained model from the Hugging Face `transformers` library to classify it as positive, negative, or neutral.
5.  **Results Aggregation:** The analysis results, including top users and sentiment correlations, are compiled.
6.  **Presentation:** The results are rendered on a clear and readable HTML page using the FastAPI web framework and Jinja2 templating.

## Technology Stack

- **Backend:** Python, FastAPI
- **Network Analysis:** `networkx`
- **NLP / Sentiment Analysis:** `transformers` (Hugging Face), `torch`, `pandas`
- **Social Media Integration:** `praw` (for Reddit)
- **Frontend:** HTML, CSS, Jinja2

## Setup and Installation

Follow these steps to set up the project locally.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/Misinformation-Propagation-Analyzer.git
    cd Misinformation-Propagation-Analyzer
    ```

2.  **Create a virtual environment:**
    ```bash
    # For Windows
    python -m venv venv
    venv\Scripts\activate

    # For macOS/Linux
    python3 -m venv venv
    source venv/bin/activate
    ```

3.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
    *Note: The first time you run the application, the `transformers` library may download the pre-trained model files, which can take a few minutes and require an internet connection.*

4.  **API Credentials:**
    If you are analyzing Reddit posts, you will need to create a `praw.ini` file in the project root with your Reddit API credentials.

## How to Run

1.  Ensure your virtual environment is activated.
2.  Run the FastAPI application using Uvicorn (assuming your main file is `main.py` and the app instance is `app`):
    ```bash
    uvicorn main:app --reload
    ```
3.  Open your web browser and navigate to `http://127.0.0.1:8000`.
4.  Paste the URL of the social media post you want to analyze and click "Analyze".

## Understanding the Results

- **Top Spreaders:** These users are highly engaging. Their comments are conversation starters that attract a high number of direct replies. They are central hubs in the discussion.
- **Top Bridges:** These users are connectors. They prevent the conversation from fragmenting into isolated silos by participating in and linking different discussion threads.
- **Sentiment vs. Average Spreader Score:** This table shows which sentiment (Positive, Negative, Neutral) is, on average, associated with more engaging comments. For example, a high score for "Negative" sentiment would suggest that negative comments tend to generate more replies in this specific post.
