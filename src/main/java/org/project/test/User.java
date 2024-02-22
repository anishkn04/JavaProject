package org.project.test;

public class User {
    private static int userCount = 0;
    private int user_id;
    private String username;
    private String password;
    private String role;

    // Constructors
    public User(String username, String password, String role) {
        this.user_id = ++userCount;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Getters
    public int getUserId() {
        return user_id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    // Setters
    public void setUser_id() {
        this.user_id = ++userCount;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean authenticate(String enteredPassword) {
        return this.password.equals(enteredPassword);
    }

    public boolean hasAccess(String requiredRole) {
        return this.role.equals(requiredRole);
    }

}
