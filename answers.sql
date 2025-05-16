-- Clinic Booking System SQL Schema
-- Author: Kelvin Asiago
-- Description: This script creates all necessary tables and relationships for a clinic booking system.

-- Drop database if it exists
DROP DATABASE IF EXISTS clinic_booking_system;

-- Create database
CREATE DATABASE clinic_booking_system;
USE clinic_booking_system;

-- Table: Patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Table: Doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    room_number VARCHAR(10) NOT NULL
);

-- Table: Services
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    fee DECIMAL(10,2) NOT NULL
);

-- Table: Appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    service_id INT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,

    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Table: Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    prescribed_date DATE NOT NULL,
    medication TEXT NOT NULL,
    dosage TEXT NOT NULL,
    instructions TEXT,

    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Table: Users (Admin/Staff Login)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Receptionist', 'Doctor') NOT NULL
);

-- Sample M-M Relation: Doctor-Service Mapping (if a doctor provides multiple services)
CREATE TABLE Doctor_Services (
    doctor_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (doctor_id, service_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);
