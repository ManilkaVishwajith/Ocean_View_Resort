package com.oceanview.model;

public class Reservation {
    private int id;
    private String customerName;
    private String email;
    private String roomType;
    private String roomPrice;
    private String checkIn;
    private String checkOut;

    public Reservation() {}

    public Reservation(String customerName, String email, String roomType, String roomPrice, String checkIn, String checkOut) {
        this.customerName = customerName;
        this.email = email;
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public String getRoomPrice() { return roomPrice; }
    public void setRoomPrice(String roomPrice) { this.roomPrice = roomPrice; }

    public String getCheckIn() { return checkIn; }
    public void setCheckIn(String checkIn) { this.checkIn = checkIn; }

    public String getCheckOut() { return checkOut; }
    public void setCheckOut(String checkOut) { this.checkOut = checkOut; }
}