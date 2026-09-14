Mint Classics — Inventory & Warehouse Analysis
Project Overview

This project analyzes inventory, sales, product performance, and warehouse utilization for Mint Classics Company. The objective is to use SQL and Power BI to identify opportunities to reduce excess inventory and evaluate whether the company could consolidate one of its storage facilities while continuing to support customer demand. The project combines data loading, data preparation, SQL analysis, DAX calculations, Power BI visualization, and business recommendations to transform raw operational data into actionable insights.

Business Objectives

The analysis focuses on three main business questions. First, where is inventory currently stored and could the warehouse structure be reorganized to eliminate one facility? Second, how do current inventory levels relate to product sales, and are inventory quantities appropriate for demand? Third, are there non-moving products that could be considered for inventory reduction or further product-line review?

Tools & Technologies

The project was completed using MySQL for database loading and SQL analysis, Excel for data preparation and Power BI data sourcing, Power BI for interactive dashboards and visualization, and DAX for business measures and warehouse consolidation calculations. GitHub is used to document and present the project as a portfolio project.

Project Workflow

The project began by loading the Mint Classics database into MySQL. The database contains information about products, product lines, warehouses, orders, order details, customers, employees, offices, and payments. The relevant tables for the inventory analysis were primarily products, orderdetails, orders, and warehouses.

The data was then reviewed and prepared for analysis. SQL queries were created to examine units sold by product, products with no recorded sales, slowest-selling products, stock-to-sales ratios, inventory value, high-value inventory with low sales, warehouse capacity utilization, inventory by warehouse, sales by warehouse, product counts by warehouse, product-line performance, and warehouse consolidation scenarios.

The SQL analysis was then converted into a Power BI dashboard consisting of three pages. The first page, Executive Overview, provides a high-level view of total inventory, total units sold, inventory value, sales value, inventory by warehouse, sales by warehouse, warehouse capacity utilization, and interactive warehouse and product-line filters. The second page, Product & Inventory Analysis, focuses on the top-selling products, slowest-selling products, inventory value by product line, sales value by product line, inventory versus sales by product, and non-moving products. The third page, Warehouse Consolidation, focuses on inventory and sales by warehouse, inventory value, product count, warehouse comparisons, and the South-to-West warehouse consolidation scenario.

Key Findings

Warehouse capacity utilization varies across the four facilities. South operates at 75% utilization, North at 72%, East at 67%, and West at 50%. West therefore has the lowest current capacity utilization and the greatest estimated available capacity.

East holds the largest amount of inventory with 219,183 units, followed by North with 131,688 units, West with 124,880 units, and South with 79,380 units. East also has the highest recorded sales volume with 35,582 units sold, followed by North with 24,650, West with 22,933, and South with 22,351.

Warehouse Consolidation Analysis

Based on the available inventory and capacity data, South was identified as the strongest candidate for potential consolidation into West. South currently holds 79,380 units of inventory, while West holds 124,880 units and currently operates at 50% capacity. If South's inventory were transferred to West, the combined inventory would be 204,260 units. Based on West's current inventory representing approximately 50% utilization, its estimated full capacity is approximately 249,760 units. The estimated utilization after the transfer would therefore be approximately 81.8%, leaving approximately 18.2% estimated spare capacity.

Based on this inventory-capacity scenario, Mint Classics should evaluate consolidating the South warehouse into the West warehouse. However, this is an inventory-capacity assessment rather than a final operational decision. Before implementation, the company should validate physical warehouse constraints, transportation costs, customer locations, product handling requirements, staffing requirements, warehouse operating costs, and the actual ability to maintain the required 24-hour shipping service level.

Inventory Reduction Opportunities

The analysis also identified products that require further review based on their sales activity and current inventory. One notable example is the 1985 Toyota Supra, which has 7,733 units in stock and 0 recorded sales. This makes it a strong candidate for further review for discontinuation or substantial inventory reduction. Products with high stock-to-sales ratios were also identified as potential areas for inventory optimization.

However, high inventory does not automatically mean that a product should be discontinued. Products with strong sales and relatively low inventory may instead require replenishment or closer inventory monitoring. Inventory reduction should therefore be based on demand and inventory efficiency rather than simply reducing stock across all products.

Business Insights

The analysis shows that warehouse utilization varies significantly across facilities, with West having the lowest current utilization. The South-to-West scenario indicates that West could potentially absorb South's current inventory while remaining below full estimated capacity. At the product level, some products have substantial inventory despite limited or zero recorded sales, while strong-selling products with relatively low inventory may require closer monitoring or replenishment.

Final Recommendation

The analysis recommends that Mint Classics evaluate the possibility of consolidating the South warehouse into the West warehouse. The available inventory and capacity data indicate that West could accommodate South's current inventory at an estimated 81.8% utilization, leaving approximately 18.2% estimated spare capacity. In addition, non-moving and excessively stocked products should be reviewed to reduce unnecessary inventory holding costs. The final warehouse decision should only be made after validating operational factors that are not represented in the database, particularly transportation, customer geography, physical storage constraints, product handling requirements, and actual shipping performance.
