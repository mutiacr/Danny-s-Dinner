
# 🍜 Case Study #1: Danny's Diner 
### 8-Week SQL Challenge

## 📌 Project Overview
This project is part of the **8-Week SQL Challenge** by Danny Ma. It involves analyzing a restaurant's customer data to help the owner, Danny, understand his customers' visiting patterns, spending habits, and their favorite menu items.

## 📖 Business Request
Danny wants to use the data to answer questions about his customers, including:
- Visiting patterns and frequency.
- Total amount spent per customer.
- Most popular menu items.
- Impact of the loyalty program on customer behavior.

## 🛠️ Tech Stack & SQL Skills
*   **Database:** PostgreSQL / MySQL
*   **Key Concepts:**
    *   **Joins:** `INNER JOIN`, `LEFT JOIN` for multi-table analysis.
    *   **Aggregations:** `SUM()`, `COUNT()`, `MIN()`, `GROUP BY`.
    *   **Subqueries & CTEs:** For modular and readable logic.
    *   **Window Functions:** `RANK()`, `DENSE_RANK()`, and `OVER(PARTITION BY...)`.
    *   **Conditional Logic:** `CASE WHEN` for point systems and membership status.

---

## 📂 Dataset Structure
The database consists of three key tables:
1.  **`sales`**: Captures all customer orders and transaction dates.
2.  **`menu`**: Contains product names and unit prices.
3.  **`members`**: Stores the date when customers joined the loyalty program.

---

## 📈 Summary of Findings
1.  **`Top Performer`**: Ramen is the most popular item overall, making it a key driver for restaurant revenue.
2.  **`Customer Loyalty`**: Customer A is the most frequent visitor, while Customer B shows a more diverse ordering pattern.
3.  **`Member Behavior`**: There is a clear "activation" period where customers tend to try new items immediately after joining the loyalty program.
