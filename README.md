# E-Mart: Java-based E-Commerce Platform


## 📑 Table of Contents

- [Introduction](#introduction)
- [Key Features](#key-features)
- [Technology Stack](#technology-stack)
- [Architecture Overview](#architecture-overview)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Project Structure](#project-structure)
- [Core Components](#core-components)
  - [Entity Classes](#entity-classes)
  - [DAO Pattern Implementation](#dao-pattern-implementation)
  - [Servlet Controllers](#servlet-controllers)
  - [Helper Classes](#helper-classes)
- [Authentication Flow](#authentication-flow)
- [Product Management](#product-management)
- [User Management](#user-management)
- [Design Patterns Used](#design-patterns-used)
- [Installation Guide](#installation-guide)
- [Usage Guide](#usage-guide)
- [Contributing](#contributing)
- [Future Enhancements](#future-enhancements)

## Introduction

E-Mart (also referred to as "MyCart" in the codebase) is a comprehensive, feature-rich e-commerce platform built with Java EE technologies. The application provides a complete online shopping experience, enabling users to browse products by category, manage a shopping cart, and complete purchases, while administrators can manage products, categories, and monitor user activity through an intuitive dashboard.

This project demonstrates the implementation of core Java EE concepts, Hibernate ORM for database operations, session management for user authentication, and responsive UI design for an optimal shopping experience across devices.

## Key Features

- **Dual User Roles**: Separate interfaces and permissions for normal users and administrators
- **Product Catalog**: Browse products with detailed descriptions, images, and pricing information
- **Category Management**: Organize and filter products by categories
- **User Authentication**: Secure registration and login system with session management
- **Admin Dashboard**: Comprehensive interface for administrators to manage products, categories, and view statistics
- **Responsive Design**: Mobile-friendly user interface for shopping on any device
- **Discount System**: Support for product discounts with automatic price calculations
- **Image Upload**: Product image management with file system storage
- **Data Validation**: Client and server-side validation for user inputs

## Technology Stack

<table>
  <tr>
    <th>Component</th>
    <th>Technology</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td>Backend</td>
    <td>Java EE (Servlets)</td>
    <td>Server-side application logic and request handling</td>
  </tr>
  <tr>
    <td>ORM</td>
    <td>Hibernate 5.4.28</td>
    <td>Object-relational mapping for database operations</td>
  </tr>
  <tr>
    <td>Database</td>
    <td>MySQL 5.1.48</td>
    <td>Persistent data storage</td>
  </tr>
  <tr>
    <td>Frontend</td>
    <td>JSP, HTML, CSS, JavaScript</td>
    <td>User interface rendering and interaction</td>
  </tr>
  <tr>
    <td>Build Tool</td>
    <td>Maven 3.1</td>
    <td>Dependency management and project build</td>
  </tr>
  <tr>
    <td>Web Server</td>
    <td>Apache Tomcat</td>
    <td>Servlet container for deploying the application</td>
  </tr>
  <tr>
    <td>IDE</td>
    <td>NetBeans</td>
    <td>Development environment</td>
  </tr>
</table>

## Architecture Overview

E-Mart follows a Model-View-Controller (MVC) architecture, designed to separate concerns and enhance maintainability:


1. **Model Layer**: Entity classes (User, Product, Category) represent database tables and data structures
2. **View Layer**: JSP pages render the user interface and display data
3. **Controller Layer**: Servlet classes handle HTTP requests, process data, and control application flow
4. **Data Access Layer**: DAO (Data Access Object) classes encapsulate database operations for each entity
5. **Helper Classes**: Utility classes provide common functionality across the application

The application uses Hibernate ORM to map Java objects to database tables, simplifying database operations and reducing boilerplate code. Database connections are managed through a SessionFactory, implemented with a singleton pattern to ensure efficient resource usage.

## Entity Relationship Diagram


The database schema consists of three primary entities:

1. **User**
   - Represents application users with roles (admin/normal)
   - Stores authentication details and personal information
   - Primary key: userId

2. **Category**
   - Classifies products into logical groups
   - Contains title and description
   - Primary key: categoryID
   - One-to-many relationship with Product

3. **Product**
   - Represents items for sale
   - Contains details like price, description, image path, discount, etc.
   - Primary key: pId
   - Many-to-one relationship with Category

Key relationships:
- One Category can have many Products (One-to-Many)
- Each Product belongs to exactly one Category (Many-to-One)

## Project Structure

The project follows a standard Maven directory structure:

```
mycart/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── learn/
│   │   │           └── mycart/
│   │   │               ├── dao/           # Data Access Objects
│   │   │               ├── entities/      # Entity classes (JPA)
│   │   │               ├── helper/        # Utility classes
│   │   │               └── servlets/      # Controller servlets
│   │   ├── resources/
│   │   │   └── hibernate.cfg.xml          # Hibernate configuration
│   │   └── webapp/
│   │       ├── img/                       # Image storage location
│   │       │   └── products/              # Product images
│   │       ├── js/                        # JavaScript files
│   │       ├── css/                       # CSS stylesheets
│   │       ├── components/                # Reusable JSP components
│   │       ├── WEB-INF/                   # Web application config
│   │       ├── admin.jsp                  # Admin dashboard
│   │       ├── index.jsp                  # Home page
│   │       ├── login.jsp                  # Login page
│   │       └── register.jsp               # Registration page
└── pom.xml                                # Maven project configuration
```

## Core Components

### Entity Classes

#### User Entity

```java
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10, name = "user_id")
    private int userId;
    
    @Column(length = 100, name = "user_name")
    private String userName;
    
    @Column(length = 100, name = "user_email")
    private String userEmail;
    
    // Other fields and methods...
    
    @Column(name = "user_type")
    private String userType; // "admin" or "normal"
}
```

The User entity represents application users with two possible roles: admin and normal. It stores authentication information (email, password), personal details (name, phone, address), and the user type which determines access rights.

#### Category Entity

```java
@Entity
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryID;
    private String categoryTitle;
    private String categoryDescription;
    
    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();
    
    // Constructors, getters, setters...
}
```

The Category entity organizes products into logical groups. It has a one-to-many relationship with Product, so a single category can contain multiple products.

#### Product Entity

```java
@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pId;
    private String pName;
    
    @Column(length = 3000)
    private String pDesc;
    private String pPhoto;
    private int pPrice;
    private int pDiscount;
    private int pQuantity;
    
    @ManyToOne
    private Category category;
    
    // Constructors, getters, setters...
    
    // Calculate price after discount
    public int getPriceAfterApplyingDiscount() {
        int d = (int)((this.getpDiscount()/100.0) * this.getpPrice());
        return this.getpPrice()-d;
    }
}
```

The Product entity represents items for sale in the e-commerce system. It has a many-to-one relationship with Category, meaning each product belongs to exactly one category.

### DAO Pattern Implementation

The Data Access Object (DAO) pattern isolates the application/business layer from the persistence layer, providing a clean separation of concerns:

#### UserDao

```java
public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    // Get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        // Implementation...
    }
    
    // Get user by email
    public User getUserByEmail(String email) {
        // Implementation...
    }
}
```

#### CategoryDao

```java
public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    // Save category to database
    public int saveCategory(Category cat) {
        // Implementation...
    }
    
    // Get all categories
    public List<Category> getCategories() {
        // Implementation...
    }
    
    // Get category by ID
    public Category getCategoryById(int cid) {
        // Implementation...
    }
}
```

#### ProductDao

```java
public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    // Save product
    public boolean saveProduct(Product product) {
        // Implementation...
    }
    
    // Get all products
    public List<Product> getAllProducts() {
        // Implementation...
    }
    
    // Get all products of a specific category
    public List<Product> getAllProductsById(int cid) {
        // Implementation...
    }
}
```

### Servlet Controllers

Servlets handle HTTP requests, process data, and control the application flow:

#### RegisterServlet

Handles user registration, performs validation, and creates new user accounts.

#### LoginServlet

Authenticates users, creates sessions, and redirects to appropriate pages based on user role.

#### LogoutServlet

Terminates user sessions and redirects to the login page.

#### ProductOperationServlet

Handles both category and product management operations (add, update).

### Helper Classes

#### FactoryProvider

```java
public class FactoryProvider {
    private static SessionFactory factory;
    
    public static SessionFactory getFactory() {
        try {
            if(factory == null) { // Singleton pattern
                factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return factory;
    }
}
```

This class implements the Singleton pattern to ensure only one SessionFactory instance exists throughout the application's lifecycle.

#### Helper

```java
public class Helper {
    // Get first 10 words of a description
    public static String get10Words(String desc) {
        // Implementation...
    }
    
    // Get counts of users and products
    public static Map<String, Long> getCounts(SessionFactory factory) {
        // Implementation...
    }
}
```

The Helper class provides utility methods used across the application, such as truncating descriptions and retrieving statistics.

## Authentication Flow


1. **Registration Process**:
   - User submits registration form from register.jsp
   - RegisterServlet validates input and checks if email already exists
   - If validation passes, a new User object is created with "normal" user type
   - User is saved to the database and redirected to register.jsp with success message

2. **Login Process**:
   - User submits login form from login.jsp
   - LoginServlet validates credentials using UserDao
   - If valid, a session is created with the user object stored as "current-user"
   - User is redirected based on role: admins to admin.jsp, normal users to index.jsp

3. **Session Management**:
   - Active user sessions store the "current-user" attribute
   - JSP pages check this attribute to restrict access to protected areas
   - Navigation components adapt based on user login status and role

4. **Logout Process**:
   - User clicks logout link
   - LogoutServlet removes the "current-user" attribute from session
   - User is redirected to login.jsp

## Product Management


1. **Adding Categories**:
   - Admin accesses the category form
   - Submits category title and description
   - ProductOperationServlet creates a new Category object
   - CategoryDao saves the object to the database

2. **Adding Products**:
   - Admin fills product form with details and selects category
   - Uploads product image
   - ProductOperationServlet creates Product object and associates with selected Category
   - ProductDao saves product to database
   - Image is stored in the file system with path referenced in the database

3. **Displaying Products**:
   - Products are fetched by ProductDao and displayed on home page
   - Users can filter products by category
   - Discount calculations are performed automatically

## User Management

E-Mart implements a role-based access control system with two user types:

1. **Normal Users**:
   - Can browse products
   - Filter products by category
   - Add items to cart
   - Complete purchases
   - View order history

2. **Admin Users**:
   - Have all normal user capabilities
   - Can access admin dashboard
   - Add/manage product categories
   - Add/edit/remove products
   - View system statistics

## Design Patterns Used

1. **Model-View-Controller (MVC)**: Separates the application into three main components:
   - Model: Entity classes and DAOs
   - View: JSP pages
   - Controller: Servlet classes

2. **Data Access Object (DAO)**: Abstracts database operations:
   - UserDao, CategoryDao, ProductDao

3. **Singleton Pattern**: Ensures single instance of resource-intensive objects:
   - FactoryProvider for Hibernate SessionFactory

4. **Front Controller**: Centralizes request handling:
   - Servlets route and process all HTTP requests

5. **Session Facade**: Simplifies client access to complex subsystems:
   - Helper methods in dao classes

## Installation Guide

### Prerequisites

- JDK 1.7 or higher
- Maven 3.1 or higher
- MySQL 5.x
- Apache Tomcat 8.x or higher
- NetBeans IDE (recommended)

### Database Setup

1. Create a MySQL database named "mycart":
   ```sql
   CREATE DATABASE mycart;
   ```

2. Update database connection details in `hibernate.cfg.xml`:
   ```xml
   <property name="connection.url">jdbc:mysql://localhost:3306/mycart</property>
   <property name="connection.username">your_username</property>
   <property name="connection.password">your_password</property>
   ```

### Project Setup

1. Clone the repository:
   ```
   git clone https://github.com/Arshnoor-Singh-Sohi/emart.git
   ```

2. Navigate to project directory:
   ```
   cd emart
   ```

3. Build the project:
   ```
   mvn clean install
   ```

4. Deploy the generated WAR file to Tomcat:
   - Copy `target/mycart-1.0-SNAPSHOT.war` to Tomcat's webapps directory
   - Or deploy directly from NetBeans

5. Start Tomcat:
   ```
   catalina.bat start
   ```

6. Access the application:
   ```
   http://localhost:8080/mycart/
   ```

## Usage Guide

### Admin Account Setup

1. Register a new user
2. Manually update the user_type in the database to "admin":
   ```sql
   UPDATE user SET user_type = 'admin' WHERE user_email = 'admin@example.com';
   ```

### Admin Dashboard

1. Login with admin credentials
2. Access the dashboard to:
   - View statistics
   - Add new categories
   - Add new products
   - Manage inventory

### Shopping as a User

1. Register a new account or login
2. Browse products on the home page
3. Filter products by category
4. Add items to cart
5. Proceed to checkout

## Contributing

Contributions to E-Mart are welcome! Here's how you can contribute:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -m 'Add feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request

### Coding Standards

- Follow Java naming conventions
- Write comprehensive JavaDoc comments
- Include unit tests for new features
- Ensure responsive design for UI changes

## Future Enhancements

1. **Shopping Cart Persistence**: Store cart items in the database
2. **Order Management**: Complete order processing system
3. **Payment Gateway Integration**: Support for online payments
4. **User Profile Management**: Allow users to update their information
5. **Advanced Search**: Implement product search functionality
6. **Reviews and Ratings**: Let users rate and review products
7. **Wishlist**: Allow users to save products for later
8. **Responsive Admin Dashboard**: Mobile-friendly admin interface
9. **Email Notifications**: Order confirmations and status updates
10. **Inventory Management**: Low stock alerts and automatic reordering

---

This project was developed as a demonstration of Java web application development with a focus on e-commerce functionality. The implementation showcases the use of modern Java technologies, design patterns, and best practices for building scalable web applications.
