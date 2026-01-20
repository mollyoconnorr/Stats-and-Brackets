# March Madness First-Round Predictor

A **data-driven machine learning model** to predict first-round NCAA Men’s Basketball Tournament outcomes, using historical game results (2008–2025) and KenPom efficiency metrics (2002–2025). The model leverages **feature engineering, Random Forests, and hyperparameter tuning** to provide accurate predictions, outperforming baseline strategies such as always picking the higher seed or prior bracket results.

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Motivation](#motivation)  
3. [Data Sources](#data-sources)  
4. [Feature Engineering](#feature-engineering)  
5. [Modeling Approach](#modeling-approach)  
6. [Hyperparameter Tuning](#hyperparameter-tuning)  
7. [Model Evaluation](#model-evaluation)  
8. [Web Application Deployment](#web-application-deployment)  
9. [Limitations and Future Work](#limitations-and-future-work)  
10. [Installation and Usage](#installation-and-usage)  
11. [References](#references)  

---

## Project Overview

Predicting NCAA March Madness outcomes is notoriously challenging due to frequent upsets, variable team performance, and the single-elimination tournament format.  

This project focuses on **first-round games**, leveraging:  

- Historical tournament results (2008–2025)  
- KenPom efficiency metrics (2002–2025)  
- Dean Oliver’s “Four Factors” (effective field goal %, offensive rebounding rate, turnover rate, free throw rate)  

Using **Random Forest classifiers** and systematic feature selection, the model identifies the most predictive variables for first-round games, achieving a **test accuracy of 79.82%**, outperforming baselines including:  

- Random guessing: 50%  
- Always picking higher-seeded teams: 71.64%  
- Prior bracket strategies: 75%  

The model is also deployed as a **web-based GUI**, allowing real-time predictions for matchups.

---

## Motivation

March Madness captivates millions of fans annually. Filling out brackets has become a cultural phenomenon, yet consistently predicting game outcomes remains extremely difficult.  

The motivation behind this project:  

- Use **data-driven methods** to identify patterns and predictors of first-round wins  
- Build a **practical predictive tool** for fans, analysts, and enthusiasts  
- Explore **feature importance** to understand what statistical factors most influence first-round results  

---

## Data Sources

The model uses two primary datasets:

| Dataset | Content | Years Covered |
|---------|--------|---------------|
| **March Madness Results** | Game outcomes, seeds, team names, round exits | 2008–2024 |
| **KenPom Metrics** | Efficiency ratings, tempo-adjusted statistics, team stats | 2002–2024 |

https://www.kaggle.com/datasets/jonathanpilafas/2024-march-madness-statistical-analysis



**Data preprocessing steps included**:  

- Restricting KenPom metrics to **pre-tournament values** to avoid data leakage  
- Standardizing team names and resolving mismatches  
- Merging datasets on team name and season  

The final **master dataset** includes team-level efficiency metrics, seeding, and round exit information.

---

## Feature Engineering

### Base Features
Started with Dean Oliver’s **Four Factors**:  

1. Effective Field Goal % (eFG%)  
2. Turnover % (TO%)  
3. Offensive Rebound % (OR%)  
4. Free Throw Rate (FTR)  

Including tournament **seed** improved model accuracy significantly.

### Engineered Features
Additional features were designed to capture nuanced relationships:  

- **AdjEM/AdjTempo Ratio** – efficiency per possession  
- **Height × Experience Interaction** – combined advantage of taller, experienced teams  
- **Seed × AdjEM Interaction** – models how team strength interacts with tournament seeding  

### Top Predictive Features
The final **7 features** selected for the model:

1. AdjEM_AdjTempo_ratio – efficiency per possession  
2. AdjEM – adjusted efficiency margin  
3. SEED – tournament seed  
4. Seed_AdjEM_interaction – team strength × seed  
5. FG2Pct_diff – difference in two-point shooting %  
6. ORPct – offensive rebounding %  
7. TOPct – turnover %  

---

## Modeling Approach

- **Algorithm**: Random Forest Classifier  
- **Objective**: Predict win/loss for first-round games  
- **Train/Test Split**: 70% training, 30% testing  

The Random Forest approach was selected to:  

- Capture nonlinear relationships among features  
- Provide interpretable feature importance measures  
- Handle both raw statistics and engineered interactions  

**Initial model accuracy** with Four Factors: ~60%  
**After including seed & expanded features**: up to 77.49%  
**Final model with top 7 engineered features**: 79.82%  

---

## Hyperparameter Tuning

Sequential tuning of key Random Forest parameters:

| Parameter | Selected Value | Description |
|-----------|----------------|-------------|
| n_estimators | 100 | Number of decision trees |
| max_depth | 4 | Maximum tree depth |
| min_samples_split | 60 | Minimum samples to split a node |
| min_samples_leaf | 7 | Minimum samples per leaf node |

Hyperparameter tuning improved model accuracy slightly (~0.3%), indicating **most predictive power was captured in careful feature selection**.

---

## Model Evaluation

Performance compared to common baselines:

| Strategy | Accuracy | Z-Statistic | P-Value |
|----------|----------|------------|---------|
| Random Guess | 50% | 13.7438 | 0.0000 |
| Higher Seed | 71.64% | 3.7716 | 0.0001 |
| Previous Bracket | 75% | 2.2233 | 0.0131 |
| Random Forest (Top 7 Features) | 79.82% | - | - |

**Conclusion**: Random Forest significantly outperforms both simple heuristics and historical bracket choices.

---

## Web Application Deployment

The model was **exported from Python to JavaScript** and embedded in a **GUI-based web interface**:

- Users input team statistics (e.g., adjusted efficiency, height, seed)  
- Model outputs **predicted winner** and **win probability** in real-time  

This ensures accessibility for fans or analysts without requiring Python or data science knowledge.

---

## Limitations & Future Work

### Current Limitations:

- Focuses only on first-round games  
- Does not account for dynamic factors (team momentum, injuries, coaching strategies)  
- Limited to historical efficiency metrics  

### Potential Extensions:

- Extend predictions to **later rounds**  
- Incorporate **dynamic variables** (e.g., player injuries, team streaks, matchup-specific stats)  
- Explore **other algorithms** (e.g., XGBoost, neural networks) for performance gains  

---

## Installation & Usage

**Requirements**:

- Python 3.10+  
- Packages: `pandas`, `numpy`, `scikit-learn`, `matplotlib`  
- JavaScript-compatible web browser for the GUI  

**Usage (Python Model)**:

```bash
git clone https://github.com/yourusername/march-madness-predictor.git
cd march-madness-predictor
python predict_first_round.py
```

**Web Application**:

https://mollyoconnorr.github.io/Stats-and-Brackets/

---

## References

- Oliver, D. (2004). *Basketball on Paper*.  
- Pomeroy, K. (2005–2025). *KenPom Efficiency Ratings*.  
- Poropudas, R. (2023). *Basketball Metrics Analysis*.  
- Cunningham, T. (2025). *College Basketball Analytics*.  
- Kavlakoglu, D. (2025). *Machine Learning in Sports*.  
- Fore, J. (2025). *March Madness Bracket Odds*.
