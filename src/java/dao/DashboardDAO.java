/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import dtos.CategoriesStatisticDTO;
import dtos.DashboardStatisticDTO;
import dtos.RecentActivityDTO;
import dtos.UsersStatisticDTO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import model.User;

/**
 *
 * @author quan
 */
public class DashboardDAO extends dao {
    
    public static void main(String[] args) {
        DashboardDAO dao = new DashboardDAO();
        System.out.println(dao.getNewestUsers(5));
    }
    
    private final Logger logger = Logger.getLogger(this.getClass().getName());
    
    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }
    
    public DashboardStatisticDTO getAdminStatistic() {
        DashboardStatisticDTO stat = null;
        String sql = """
                     SELECT 
                         (SELECT COUNT(*) FROM user) as totalUsers,
                         (SELECT COUNT(*) FROM user WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())) as newUsersThisMonth,
                         (SELECT COUNT(*) FROM course) as totalCourses,
                         (SELECT COUNT(*) FROM course WHERE status = 'Active') as activeCourses,
                         (SELECT COUNT(*) FROM enrollment) as totalEnrollments,
                         (SELECT COUNT(DISTINCT e.user_id) FROM enrollment e JOIN course_progress cp ON e.user_id = cp.user_id WHERE YEARWEEK(cp.last_accessed_at, 1) = YEARWEEK(CURRENT_DATE(), 1)) as enrollmentsThisWeek,
                         (SELECT ROUND((COUNT(CASE WHEN status = 'Completed' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0)), 1) FROM enrollment) as completionRate,
                         (SELECT COUNT(DISTINCT course_id) FROM enrollment WHERE status = 'Completed') as completedCourses,
                         (SELECT COUNT(*) FROM category) as totalCategories,
                         (SELECT COUNT(*) FROM test) as totalTests,
                         (SELECT COUNT(*) FROM quiz) as totalQuizzes,
                         (SELECT COUNT(*) FROM media) as totalMedia;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                stat = new DashboardStatisticDTO(
                        rs.getInt("totalUsers"),
                        rs.getInt("newUsersThisMonth"),
                        rs.getInt("totalCourses"),
                        rs.getInt("activeCourses"),
                        rs.getInt("totalEnrollments"),
                        rs.getInt("enrollmentsThisWeek"),
                        rs.getFloat("completionRate"),
                        rs.getInt("completedCourses"),
                        rs.getInt("totalCategories"),
                        rs.getInt("totalTests"),
                        rs.getInt("totalQuizzes"),
                        rs.getInt("totalMedia")
                );
            }
            
            return stat;
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return stat;
        } finally {
            this.closeResources();
        }
    }
    
    public List<User> getNewestUsers(int limit) {
        List<User> uList = new ArrayList<>();
        String sql = """
                     SELECT 
                             u.id,
                             u.first_name as firstName,
                             u.last_name as lastName,
                             u.email,
                             u.status,
                             u.created_at as createdAt,
                             r.name as roleName
                         FROM user u
                         JOIN role r ON u.role_id = r.id
                         ORDER BY u.created_at DESC
                         LIMIT ?;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, limit);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                User u = new User();
                
                u.setId(rs.getInt("id"));
                u.setFirst_name(rs.getString("firstName"));
                u.setLast_name(rs.getString("lastName"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status"));
                u.setCreated_at(rs.getTimestamp("createdAt"));
                
                uList.add(u);
            }
            
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }
        
        return uList;
    }
    
    public List<Course> getPopularCourses(int limit) {
        List<Course> cList = new ArrayList<>();
        String sql = """
                     SELECT 
                         c.id,
                         c.title,
                         c.thumbnail,
                         cat.name as categoryName,
                         COUNT(e.user_id) as enrollmentCount
                     FROM course c
                     LEFT JOIN enrollment e ON c.id = e.course_id
                     JOIN category cat ON c.category_id = cat.id
                     WHERE c.status = 'Active'
                     GROUP BY c.id, c.title, c.thumbnail, cat.name
                     ORDER BY enrollmentCount DESC
                     LIMIT ?;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, limit);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Course c = new Course(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("thumbnail"),
                        rs.getString("categoryName"),
                        rs.getInt("enrollmentCount")
                );
                
                cList.add(c);
            }
            
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }
        
        return cList;
    }
    
    public List<RecentActivityDTO> getRecentActivity(int limit) {
        List<RecentActivityDTO> recentList = new ArrayList<>();

        // Query kết hợp cả enrollment và completion, sắp xếp theo thời gian
        String sql = """
                 (SELECT 
                     'enrollment' as type,
                     CONCAT(u.first_name, ' ', u.last_name, ' đã đăng ký khóa "', c.title, '"') as description,
                     cp.last_accessed_at as activityTime,
                     CASE 
                         WHEN TIMESTAMPDIFF(MINUTE, cp.last_accessed_at, NOW()) < 60 
                             THEN CONCAT(TIMESTAMPDIFF(MINUTE, cp.last_accessed_at, NOW()), ' phút trước')
                         WHEN TIMESTAMPDIFF(HOUR, cp.last_accessed_at, NOW()) < 24 
                             THEN CONCAT(TIMESTAMPDIFF(HOUR, cp.last_accessed_at, NOW()), ' giờ trước')
                         ELSE CONCAT(TIMESTAMPDIFF(DAY, cp.last_accessed_at, NOW()), ' ngày trước')
                     END as timeAgo
                 FROM course_progress cp
                 JOIN user u ON cp.user_id = u.id
                 JOIN course c ON cp.course_id = c.id
                 WHERE cp.progress_percent = 0 
                   AND cp.status = 'InProgress'
                 ORDER BY cp.last_accessed_at DESC
                 LIMIT ?)
                 
                 UNION ALL
                 
                 (SELECT 
                     'completion' as type,
                     CONCAT(u.first_name, ' ', u.last_name, ' đã hoàn thành khóa "', c.title, '"') as description,
                     cp.completed_at as activityTime,
                     CASE 
                         WHEN TIMESTAMPDIFF(MINUTE, cp.completed_at, NOW()) < 60 
                             THEN CONCAT(TIMESTAMPDIFF(MINUTE, cp.completed_at, NOW()), ' phút trước')
                         WHEN TIMESTAMPDIFF(HOUR, cp.completed_at, NOW()) < 24 
                             THEN CONCAT(TIMESTAMPDIFF(HOUR, cp.completed_at, NOW()), ' giờ trước')
                         ELSE CONCAT(TIMESTAMPDIFF(DAY, cp.completed_at, NOW()), ' ngày trước')
                     END as timeAgo
                 FROM course_progress cp
                 JOIN user u ON cp.user_id = u.id
                 JOIN course c ON cp.course_id = c.id
                 WHERE cp.status = 'Completed' 
                   AND cp.completed_at IS NOT NULL
                 ORDER BY cp.completed_at DESC
                 LIMIT ?)
                 
                 ORDER BY activityTime DESC
                 LIMIT ?
                 """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            // Set 3 parameters cho 3 LIMIT clauses
            ps.setInt(1, limit);  // LIMIT cho enrollment query
            ps.setInt(2, limit);  // LIMIT cho completion query
            ps.setInt(3, limit);  // LIMIT cho kết quả cuối cùng

            rs = ps.executeQuery();
            
            while (rs.next()) {
                RecentActivityDTO ra = new RecentActivityDTO(
                        rs.getString("type"),
                        rs.getString("description"),
                        rs.getTimestamp("activityTime").toLocalDateTime(),
                        rs.getString("timeAgo")
                );
                recentList.add(ra);
            }
            
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }
        
        return recentList;
    }
    
    public List<UsersStatisticDTO> getUsersStatisticChartData(int dayCount) {
        List<UsersStatisticDTO> usList = new ArrayList<>();
        String sql = """
                     SELECT 
                         DATE(created_at) as date,
                         DAYNAME(created_at) as dayName,
                         COUNT(*) as userCount
                     FROM user
                     WHERE created_at >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY)
                     GROUP BY DATE(created_at), DAYNAME(created_at)
                     ORDER BY date ASC;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, dayCount);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                UsersStatisticDTO us = new UsersStatisticDTO(rs.getDate("date"), rs.getString("dayName"), rs.getInt("userCount"));
                usList.add(us);
            }
            
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }
        
        return usList;
    }
    
    public List<CategoriesStatisticDTO> getCategoriesStatisticChartData() {
        List<CategoriesStatisticDTO> csList = new ArrayList<>();
        String sql = """
                     SELECT 
                         parent_cat.name as categoryName,
                         COUNT(c.id) as courseCount,
                         ROUND((COUNT(c.id) * 100.0 / NULLIF((SELECT COUNT(*) FROM course), 0)), 1) as percentage
                     FROM category parent_cat
                     LEFT JOIN category child_cat ON parent_cat.id = child_cat.parent_id OR parent_cat.id = child_cat.id
                     LEFT JOIN course c ON child_cat.id = c.category_id
                     WHERE parent_cat.parent_id IS NULL
                     GROUP BY parent_cat.id, parent_cat.name
                     ORDER BY courseCount DESC;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                CategoriesStatisticDTO cs = new CategoriesStatisticDTO(rs.getString(1), rs.getInt(2), rs.getFloat(3));
                csList.add(cs);
            }
            
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }
        
        return csList;
    }
}
