
package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class ShowInfo {

	//this function return string that represent the quary
	public static String theQuary() {
		return "SELECT patients.patient_id , patient_name, appointment_time FROM hospital.appointment \r\n" + 
				"inner join hospital.patients on appointment.patient_id = patients.patient_id\r\n" + 
				"where appointment.doctor_id = ?\r\n" + 
				"order by appointment_time";
	}
	
	//this function execute the some stored procedure, the stored procedure accept 2 variable:
	//1) the previous doctorId (the id of the doctor that enter now is id)
	//2) the patientId that is contain in the result set of the doctorId (i.e the doctor should enter patientId just from his appointment list 
	public static void executeStoredProcedure(int doctorId, Connection con) {
		String call ="{call hospital.enter_patient(?,"+ doctorId+")}";
		try {
			PreparedStatement pstmt = con.prepareStatement(call);
			int patientId = inputPatientID();
			pstmt.setInt(1, patientId);
			try {
				pstmt.executeUpdate();
				System.out.println("The patient is entering!");
			}catch (Exception ex){ex.printStackTrace();
			}

		}catch (Exception ex){ex.printStackTrace();
		}

	}
	public static void printResult(ResultSet rs) {
		try {
			int numOfColumns = rs.getMetaData().getColumnCount();
			while (rs.next()){
				for (int col = 1; col <= numOfColumns; col++){
					System.out.print(rs.getString(col) + " ");
				}
				System.out.println();
			}
		}catch(Exception ex){ex.printStackTrace();
		}
	}
	public static int inputDocID() {
		Scanner myObj = new Scanner(System.in);  // Create a Scanner object
		System.out.print("Enter doctor id: ");
		int doctorId = myObj.nextInt();  // Read user input
		return doctorId;
	}
	public static int inputPatientID() {
		Scanner myObj = new Scanner(System.in);  // Create a Scanner object
		System.out.print("Enter patient id: ");
		int patientId = myObj.nextInt();  // Read user input
		return patientId;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		try{
			Class.forName("com.mysql.jdbc.Driver");
			try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/?user=root", "root", "olololol1998")){
				
				//Q1
				String query = theQuary();
				PreparedStatement pstmt = con.prepareStatement(query);
				int doctorId = inputDocID();
				pstmt.setInt(1, doctorId);
				ResultSet rs = pstmt.executeQuery();
				printResult(rs);

				//Q2
				executeStoredProcedure(doctorId,con);
			}
		} catch (Exception ex){ex.printStackTrace();
		}
	}

}
