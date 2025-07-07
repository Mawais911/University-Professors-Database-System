# 🎓 University Professors Database System

> A relational database system designed to manage information about university professors, their affiliations, universities, and associated organizations using **PostgreSQL** and **pgAdmin 4**.

---

## 1. Introduction

### 1.1 Background

The goal of this project is to design and implement a **relational database system** for managing information about university professors, their affiliations, universities, and associated organizations.

The original dataset (`university_professors.csv`) contains raw, unstructured data with multiple relationships and repeating groups. This makes it difficult to manage, query efficiently, or scale for real-world applications.

To address this, we have implemented a **relational database schema** that normalizes the data into separate tables with defined **primary and foreign keys** to ensure **data integrity**, **efficient querying**, and **scalability**.

---

### 1.2 Goal

The main objective of this project is to:

- Normalize the raw professor data into a structured relational model.
- Define entities and relationships between professors, universities, roles, and organizations.
- Ensure **referential integrity** using primary and foreign keys.
- Provide an efficient way to store, retrieve, and update data related to university professors and their affiliations.

---

### 1.3 Requirements

#### Functional Requirements:
- Store unique professors with their first and last names.
- Track which university each professor belongs to.
- Record various roles or functions a professor has held.
- Maintain a list of affiliated organizations.
- Support **many-to-many relationships** between professors and organizations (e.g., a professor can be part of multiple organizations).

#### Non-functional Requirements:
- Ensure **data consistency** and **integrity** through proper use of constraints.
- Allow for easy **data insertion, updates, and deletion**.
- Enable complex queries involving **joins across multiple tables**.

---

## 2. Functional Description

### 2.1 Method of Use

This system will be used by:

- **Academic institutions**
- **Researchers**
- **Administrators**

who need to:

- Query professor details and affiliations.
- Analyze organizational connections.
- Retrieve historical roles of professors.
- Manage university and organization records.

It can also serve as a foundation for more advanced systems like **academic networking platforms** or **research collaboration tools**.

---

## 3. Entity Data Model

We identified the following core entities and their relationships:

### Entities:

1. **Professors**
   - Stores personal information of professors.

2. **Universities**
   - Contains details about universities where professors are employed.

3. **Organizations**
   - Lists external organizations linked to professors’ roles.

4. **Roles**
   - Describes the function or role a professor plays in an organization.

5. **Affiliations**
   - Junction table capturing the many-to-many relationship between professors and organizations, along with the role they play.

### Relationships:

- One professor works at **one university** (**1:1**).
- A professor can belong to **multiple organizations** (**M:N**).
- Each affiliation includes a specific **role/function**.

---

## 4. Table Design (Schema)

Below are the screenshots of the **old and new** database schemas.

### Old Table Design Schema

![image](https://github.com/user-attachments/assets/2efe1ac7-9722-46b4-90b2-eaa8990da0ed)


### New Table Design Schema

![image](https://github.com/user-attachments/assets/a2c8fdc2-d0e8-4aea-9138-8a0a0b1af163)


---

## 5. Frontend Screenshots

These screenshots show how users interact with the database using **pgAdmin 4**.

### `university_professors` Table

![image](https://github.com/user-attachments/assets/b6a66d36-8009-4b25-9d8c-e9359ec19682)

### `universities` Table

![image](https://github.com/user-attachments/assets/7189284b-d9c2-49f3-9e83-14bf823d5e2c)

### `organizations` Table

![image](https://github.com/user-attachments/assets/0565b12c-249c-4d1e-85bb-901a1f798b7f)

### `affiliations` Table

![image](https://github.com/user-attachments/assets/9451b527-c057-4c00-bfb9-1595c543de0f)

### Inserting Data via Query Tool

![image](https://github.com/user-attachments/assets/337b3617-1884-44fc-9762-67fe1081b17b)

---

## 6. Example Queries and Outputs

### Create Tables

```sql
CREATE TABLE universities (
    id SERIAL PRIMARY KEY,
    university TEXT NOT NULL,
    university_city TEXT NOT NULL,
    university_shortname TEXT UNIQUE NOT NULL
);

CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    university_shortname TEXT NOT NULL REFERENCES universities(university_shortname)
);

CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    organization TEXT NOT NULL UNIQUE,
    organization_sector TEXT
);

CREATE TABLE affiliations (
    affiliation_id SERIAL PRIMARY KEY,
    professor_id INT NOT NULL REFERENCES professors(professor_id),
    organization_id INT NOT NULL REFERENCES organizations(id),
    function TEXT NOT NULL
);
```


