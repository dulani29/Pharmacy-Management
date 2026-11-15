# 💊 Pharmacy Management System

A web-based application designed to streamline pharmacy operations by managing medicines, inventory, prescriptions, patient information, payments, and customer loyalty programs.

## ✨ Key Features

- **Administration:** Manage user accounts and system activities.
- **Pharmacy Management:** Handle prescriptions and patient records.
- **Inventory Management:** Manage medicines, stock levels, and pricing.
- **Checkout & Payments:** Process customer payments and transactions.
- **Loyalty Management:** Manage memberships and reward points.
- **Role-Based Access:** Dedicated dashboards for administrators, pharmacists, inventory staff, and cashiers.

## 🛠️ Tech Stack

- **Backend:** Java, Spring Boot
- **Frontend:** JSP, HTML, CSS, JavaScript
- **Database:** Microsoft SQL Server
- **Build Tool:** Maven
- **Containerization:** Docker

## 🚀 Run Locally

**Prerequisites:** Java 17+, Docker, and Microsoft SQL Server.

1. Clone the repository:

```bash
git clone <your-repository-url>
cd <project-directory>
```

2. Start SQL Server using Docker (if not already running):

```bash
docker start sqlserver
```

3. Create the database:

```sql
CREATE DATABASE pharmacy_db;
```

4. Configure database credentials:

```bash
export SPRING_DATASOURCE_USERNAME=sa
export SPRING_DATASOURCE_PASSWORD='your-password'
```

5. Run the application:

```bash
./mvnw spring-boot:run
```

6. Open **http://localhost:8080** in your browser.

## 👩‍💻 Developer

Developed using Java, Spring Boot, JSP, and Microsoft SQL Server.