/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loiqd.user;

/**
 *
 * @author GF65
 */
public class UserDTO {

    private String email;
    private String name;
    private String password;
    private boolean role;
    private boolean status;

    public UserDTO(String email, String name, String password) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = false; // is student
        this.status = true; // is New user

    }

    public UserDTO(String email, String name, String password, boolean role, boolean status) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    
    

    public UserDTO() {
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isRole() {
        return role;
    }

    public void setRole(boolean role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    
}
