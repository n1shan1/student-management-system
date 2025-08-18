import com.pojo.Student;
import com.pojo.Course;
import com.pojo.Enrollment;
import com.service.StudentService;
import com.service.CourseService;
import com.service.EnrollmentService;

public class App {
    private static java.util.Scanner scanner = new java.util.Scanner(System.in);
    private static StudentService studentService = new StudentService();
    private static CourseService courseService = new CourseService();
    private static EnrollmentService enrollmentService = new EnrollmentService();

    public static void main(String[] args) {
        boolean running = true;
        while (running) {
            displayMainMenu();
            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    studentManagementMenu();
                    break;
                case 2:
                    courseManagementMenu();
                    break;
                case 3:
                    enrollmentManagementMenu();
                    break;
                case 4:
                    displayReports();
                    break;
                case 5:
                    System.out.println("Exiting...");
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
        scanner.close();
    }

    private static void displayMainMenu() {
        System.out.println("\n=== STUDENT MANAGEMENT SYSTEM ===");
        System.out.println("1. Student Management");
        System.out.println("2. Course Management");
        System.out.println("3. Enrollment Management");
        System.out.println("4. Reports");
        System.out.println("5. Exit");
        System.out.print("Enter your choice: ");
    }

    private static void studentManagementMenu() {
        boolean running = true;
        while (running) {
            System.out.println("\n--- Student Management ---");
            System.out.println("1. Add Student");
            System.out.println("2. View All Students");
            System.out.println("3. View Individual Student");
            System.out.println("4. Update Student Name");
            System.out.println("5. Update Address");
            System.out.println("6. Update Contact");
            System.out.println("7. Update Department");
            System.out.println("8. Remove Student");
            System.out.println("9. Back to Main Menu");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    addStudent();
                    break;
                case 2:
                    viewAllStudents();
                    break;
                case 3:
                    viewIndividualStudent();
                    break;
                case 4:
                    updateStudentName();
                    break;
                case 5:
                    updateStudentAddress();
                    break;
                case 6:
                    updateStudentContact();
                    break;
                case 7:
                    updateStudentDepartment();
                    break;
                case 8:
                    removeStudent();
                    break;
                case 9:
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void courseManagementMenu() {
        boolean running = true;
        while (running) {
            System.out.println("\n--- Course Management ---");
            System.out.println("1. Add Course");
            System.out.println("2. View All Courses");
            System.out.println("3. View Individual Course");
            System.out.println("4. Update Course");
            System.out.println("5. Delete Course");
            System.out.println("6. View Courses by Department");
            System.out.println("7. Back to Main Menu");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    addCourse();
                    break;
                case 2:
                    viewAllCourses();
                    break;
                case 3:
                    viewIndividualCourse();
                    break;
                case 4:
                    updateCourse();
                    break;
                case 5:
                    deleteCourse();
                    break;
                case 6:
                    viewCoursesByDepartment();
                    break;
                case 7:
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void enrollmentManagementMenu() {
        boolean running = true;
        while (running) {
            System.out.println("\n--- Enrollment Management ---");
            System.out.println("1. Enroll Student in Course");
            System.out.println("2. View All Enrollments");
            System.out.println("3. View Student Enrollments");
            System.out.println("4. View Course Enrollments");
            System.out.println("5. Update Enrollment");
            System.out.println("6. Remove Enrollment");
            System.out.println("7. Back to Main Menu");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    enrollStudent();
                    break;
                case 2:
                    viewAllEnrollments();
                    break;
                case 3:
                    viewStudentEnrollments();
                    break;
                case 4:
                    viewCourseEnrollments();
                    break;
                case 5:
                    updateEnrollment();
                    break;
                case 6:
                    removeEnrollment();
                    break;
                case 7:
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static void displayReports() {
        System.out.println("\n--- System Reports ---");
        System.out.println("Total Students: " + studentService.totalStudents());
        System.out.println("Total Courses: " + courseService.totalCourses());
        System.out.println("Total Enrollments: " + enrollmentService.totalEnrollments());

        Student latestStudent = studentService.latestJoinedStudent();
        if (latestStudent != null) {
            System.out.println("Latest Student: " + latestStudent.getStudentName());
        }

        Course latestCourse = courseService.latestCourse();
        if (latestCourse != null) {
            System.out.println("Latest Course: " + latestCourse.getCourseName());
        }

        Enrollment latestEnrollment = enrollmentService.latestEnrollment();
        if (latestEnrollment != null) {
            System.out.println("Latest Enrollment ID: " + latestEnrollment.getEnrollmentId());
        }
    }

    // Student Management Methods
    private static void addStudent() {
        System.out.println("Enter student name:");
        String name = scanner.nextLine();
        System.out.println("Enter email:");
        String email = scanner.nextLine();
        System.out.println("Enter department:");
        String dept = scanner.nextLine();
        System.out.println("Enter address:");
        String address = scanner.nextLine();
        System.out.println("Enter city:");
        String city = scanner.nextLine();
        System.out.println("Enter state:");
        String state = scanner.nextLine();
        System.out.println("Enter country:");
        String country = scanner.nextLine();
        System.out.println("Enter pin code:");
        int pinCode = scanner.nextInt();
        scanner.nextLine();
        System.out.println("Enter contact number:");
        int contact = scanner.nextInt();
        scanner.nextLine();

        Student newStudent = new Student(0, name, email, dept, address, city, state, country, pinCode, contact,
                java.time.LocalDate.now());
        Student admitted = studentService.admitStudent(newStudent);
        System.out.println("Student admitted successfully: " + admitted);
    }

    private static void viewAllStudents() {
        System.out.println("\n--- All Students ---");
        for (Student s : studentService.getAllStudents()) {
            System.out.println(s);
        }
    }

    private static void viewIndividualStudent() {
        System.out.print("Enter student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        Student s = studentService.getIndividual(id);
        if (s != null) {
            System.out.println(s);
        } else {
            System.out.println("Student not found.");
        }
    }

    private static void updateStudentName() {
        System.out.print("Enter student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new name: ");
        String newName = scanner.nextLine();
        Student updated = studentService.updateStudentName(id, newName);
        if (updated != null) {
            System.out.println("Name updated successfully");
        } else {
            System.out.println("Student not found.");
        }
    }

    private static void updateStudentAddress() {
        System.out.print("Enter student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new address: ");
        String address = scanner.nextLine();
        System.out.print("Enter new city: ");
        String city = scanner.nextLine();
        System.out.print("Enter new state: ");
        String state = scanner.nextLine();
        System.out.print("Enter new country: ");
        String country = scanner.nextLine();
        System.out.print("Enter new pin code: ");
        int pinCode = scanner.nextInt();
        scanner.nextLine();
        Student updated = studentService.updateAddressDetails(id, address, city, state, country, pinCode);
        if (updated != null) {
            System.out.println("Address updated successfully");
        } else {
            System.out.println("Student not found.");
        }
    }

    private static void updateStudentContact() {
        System.out.print("Enter student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new email: ");
        String email = scanner.nextLine();
        System.out.print("Enter new contact number: ");
        int contact = scanner.nextInt();
        scanner.nextLine();
        Student updated = studentService.updateContactDetails(id, email, contact);
        if (updated != null) {
            System.out.println("Contact updated successfully");
        } else {
            System.out.println("Student not found.");
        }
    }

    private static void updateStudentDepartment() {
        System.out.print("Enter student ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new department: ");
        String dept = scanner.nextLine();
        Student updated = studentService.updateDepartment(id, dept);
        if (updated != null) {
            System.out.println("Department updated successfully");
        } else {
            System.out.println("Student not found.");
        }
    }

    private static void removeStudent() {
        System.out.print("Enter student ID to remove: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        Student removed = studentService.disbandStudent(id);
        if (removed != null) {
            System.out.println("Student removed successfully: " + removed.getStudentName());
        } else {
            System.out.println("Student not found.");
        }
    }

    // Course Management Methods
    private static void addCourse() {
        System.out.println("Enter course name:");
        String name = scanner.nextLine();
        System.out.println("Enter course description:");
        String description = scanner.nextLine();
        System.out.println("Enter credits:");
        int credits = scanner.nextInt();
        scanner.nextLine();
        System.out.println("Enter department:");
        String department = scanner.nextLine();

        Course newCourse = new Course(0, name, description, credits, department);
        Course added = courseService.addCourse(newCourse);
        System.out.println("Course added successfully: " + added);
    }

    private static void viewAllCourses() {
        System.out.println("\n--- All Courses ---");
        for (Course c : courseService.getCourseDao().getCourses()) {
            System.out.println(c);
        }
    }

    private static void viewIndividualCourse() {
        System.out.print("Enter course ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        Course c = courseService.getCourseById(id);
        if (c != null) {
            System.out.println(c);
        } else {
            System.out.println("Course not found.");
        }
    }

    private static void updateCourse() {
        System.out.print("Enter course ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new course name: ");
        String name = scanner.nextLine();
        System.out.print("Enter new description: ");
        String description = scanner.nextLine();
        System.out.print("Enter new credits: ");
        int credits = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new department: ");
        String department = scanner.nextLine();

        Course updated = courseService.updateCourse(id, name, description, credits, department);
        if (updated != null) {
            System.out.println("Course updated successfully");
        } else {
            System.out.println("Course not found.");
        }
    }

    private static void deleteCourse() {
        System.out.print("Enter course ID to delete: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        boolean deleted = courseService.deleteCourse(id);
        if (deleted) {
            System.out.println("Course deleted successfully");
        } else {
            System.out.println("Course not found.");
        }
    }

    private static void viewCoursesByDepartment() {
        System.out.print("Enter department name: ");
        String department = scanner.nextLine();
        System.out.println("\n--- Courses in " + department + " ---");
        for (Course c : courseService.getCoursesByDepartment(department)) {
            System.out.println(c);
        }
    }

    // Enrollment Management Methods
    private static void enrollStudent() {
        System.out.print("Enter student ID: ");
        int studentId = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter course ID: ");
        int courseId = scanner.nextInt();
        scanner.nextLine();

        Enrollment enrollment = enrollmentService.enrollStudent(studentId, courseId);
        if (enrollment != null) {
            System.out.println("Student enrolled successfully: " + enrollment);
        }
    }

    private static void viewAllEnrollments() {
        System.out.println("\n--- All Enrollments ---");
        for (Enrollment e : enrollmentService.getAllEnrollments()) {
            System.out.println(e);
        }
    }

    private static void viewStudentEnrollments() {
        System.out.print("Enter student ID: ");
        int studentId = scanner.nextInt();
        scanner.nextLine();
        System.out.println("\n--- Enrollments for Student " + studentId + " ---");
        for (Enrollment e : enrollmentService.getEnrollmentsByStudentId(studentId)) {
            System.out.println(e);
        }
    }

    private static void viewCourseEnrollments() {
        System.out.print("Enter course ID: ");
        int courseId = scanner.nextInt();
        scanner.nextLine();
        System.out.println("\n--- Enrollments for Course " + courseId + " ---");
        for (Enrollment e : enrollmentService.getEnrollmentsByCourseId(courseId)) {
            System.out.println(e);
        }
    }

    private static void updateEnrollment() {
        System.out.print("Enter enrollment ID: ");
        int enrollmentId = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new student ID: ");
        int studentId = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter new course ID: ");
        int courseId = scanner.nextInt();
        scanner.nextLine();

        Enrollment updated = enrollmentService.updateEnrollment(enrollmentId, studentId, courseId);
        if (updated != null) {
            System.out.println("Enrollment updated successfully");
        }
    }

    private static void removeEnrollment() {
        System.out.print("Enter enrollment ID to remove: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        boolean removed = enrollmentService.disbandEnrollment(id);
        if (removed) {
            System.out.println("Enrollment removed successfully");
        }
    }
}
