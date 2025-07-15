/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bc.wellness.controller;

import com.bc.wellness.view.MainDashboard;
import com.bc.wellness.model.Appointment;
import java.sql.SQLException;
import javax.swing.JOptionPane;
        

/**
 *
 * @author liamt
 */
public class AppointmentController {
    private MainDashboard view;
    private Appointment model;
    
    public AppointmentController(){
        try{
            model = new Appointment();
            view = new MainDashboard();
            setupActions();
        }
        catch (SQLException ex)
        {
            JOptionPane.showMessageDialog(null,"Database Error:" + ex.getMessage());
        }
                
    }
    
    private void setupActions(){
        //Booking an Appointment
        view.getBtnBook().addActionListener(e ->{
        String studentId = view.getStudentIdField().getText();
        String counselor = view.getCounselField().getText();
        String date = view.getDateField().getText();
        String time = view.getTimeField().getText();
        try {
            model.add(studentId, counselor, date, time, "Scheduled"); // Assume this method exists
            refreshTable();
            clearFields();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error booking appointment: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    });
        
        //Updating an Appointment
        view.getBtnUpdate().addActionListener(e -> {
        String studentId = view.getStudentIdField().getText();
        String counselor = view.getCounselField().getText();
        String date = view.getDateField().getText();
        String time = view.getTimeField().getText();
        try {
            model.update(studentId, counselor, date, time, "Scheduled"); // Assume this method exists
            refreshTable();
            clearFields();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error updating appointment: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    });
        
        //Cancelling an Appointment
        view.getBtnCancel().addActionListener(e -> {
        String studentId = view.getStudentIdField().getText();
        try {
            model.delete(studentId); // Assume this method exists
            refreshTable();
            clearFields();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error canceling appointment: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    });
        
        }
    //helper method:
    private void refreshTable() throws SQLException{
        Object [][] data = model.getAllAppointments();
        String[] colNames = {"StudentID","Counselor","Date","Time","Status"};
        view.getAppointmentsTable().setModel(new javax.swing.table.DefaultTableModel(data, columnNames) {
        @Override
        public Class<?> getColumnClass(int columnIndex) {
            return columnIndex == 0 ? Integer.class : String.class;
        }
    });
    }
    //helper method:
    private void clearFields(){
        view.getStudentIdField().setText("");
        view.getCounselField().setText("");
        view.getDateField().setText("");
        view.getTimeField().setText("");
    }
        
    public static void main(String[] args) {
        new AppointmentController();
    }
    
}
