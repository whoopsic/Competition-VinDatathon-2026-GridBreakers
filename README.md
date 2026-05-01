# VinDatathon2026: THE GRIDBREAKER - ROUND 1

Welcome to Team **Whoopsic**'s official repository for **VinDatathon 2026: The Gridbreakers**.

We operate as the Data Strategy Team for a prominent Vietnamese E-commerce Fashion Retailer, transforming raw data into actionable business solutions.

## Project Overview

This repository contains our end-to-end data pipeline and solutions for Round 1 of the VinDatathon 2026, which aims to optimize inventory allocation, promotion planning, and logistics through granular demand forecasting. Our solution is divided into three main components:

1. **Part 01 - MCQ:** Direct data extraction and calculation.

2. **Part 02 - EDA & Data Storytelling:** Multi-level visual analysis (Descriptive, Diagnostic, Predictive, Prescriptive) providing actionable business recommendations.

3. **Part 03 - Sales Forecasting:** A robust LightGBM model using *Direct Modeling with Recursive Inference* to accurately predict 548 days of future revenue.

## Repository Structure

```bash
Competition-VinDatathon-2026-GridBreakers/
│
├── data/                           
│   └── raw/                        # raw CSV files datasets
├── notebooks/                      # Jupyter notebooks
│   ├── 01_mcq/    
│   │   └── mcq_results.ipynb       # part 01 result
│   ├── 02_eda/ 
│   │   └── eda_report.ipynb        # part 02 result
│   └── 03_model/
│   │   │── baseline.ipynb
│   │   │── model.ipynb             # part 03 modeling
│   │   └── submission.csv          # part 03 submitted result
│
├── database/                       # SQL scripts
├── reports/                        # LaTeX source code for the final 4-page PDF report
├── .gitignore
└── README.md                       # You are here
```

## Reproduce Guidance

To reproduce our results and evaluate the models locally, please follow the steps below:

1. Clone the repository:
```bash 
git clone [https://github.com/whoopsic/Competition-VinDatathon-2026-GridBreakers.git](https://github.com/whoopsic/Competition-VinDatathon-2026-GridBreakers.git)
cd Competition-VinDatathon-2026-GridBreakers
```

2. Set up the environment:
```bash
pip install pandas numpy matplotlib seaborn lightgbm shap
```

3. Prepare the Data:

    Place the competition's raw CSV files into the `data/raw/` directory.

4. Run the Pipeline:

    Navigate to the `notebooks/` folder and execute the Jupyter Notebooks in sequential order.








