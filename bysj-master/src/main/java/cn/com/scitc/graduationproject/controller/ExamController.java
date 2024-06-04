package cn.com.scitc.graduationproject.controller;

import cn.com.scitc.graduationproject.dao.*;
import cn.com.scitc.graduationproject.model.*;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/")
public class ExamController {
    HttpSession session;
    @Autowired
    ExamDao examDao;
    @Autowired
    PaperDao paperDao;
    @Autowired
    StudentexamDao studentexamDao;
    @Autowired
    StudentsubjectDao studentsubjectDao;
    @Autowired
    SubjectDao subjectDao;
    @Autowired
    CourseDao courseDao;

    /**
     * 试卷列表
     */
    @RequestMapping("/examList")
    private String examList(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        Integer classid = (Integer) session.getAttribute("classid");
        List<Exam> exams = examDao.finbyclassid(classid);
        for (Exam exam : exams) {
            Course byCno = courseDao.findByCno(exam.getCno());
            exam.setCourse(byCno);
        }
        model.addAttribute("examslenth", exams.size());
        model.addAttribute("exams", exams);
        return "/student/examList";
    }

    @ResponseBody
    @RequestMapping("/findExamByEid")
    private Exam findExamByEid(@RequestBody Exam exams) {
        Exam exam = examDao.findByEid(exams.getEid());
        if (exam != null) {
            return exam;
        } else {
            return null;
        }
    }

    /**
     * 试卷
     */
    @RequestMapping("/paper")
    private String paper(Integer eid, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        // 假设用户对象存储在会话中的 "user" 属性中
        User lis = (User) session.getAttribute("user");
        if (lis != null) {
            session.setAttribute("lis", lis);
        }
        List<Paper> singleList = paperDao.finbytype(eid, 1);
        Integer cont = singleList.size();
        request.getSession().setAttribute("single", singleList);
        System.out.println("Single" + singleList);
        model.addAttribute("single", singleList);
        model.addAttribute("cont", cont);
        List<Paper> multipleList = paperDao.finbytype(eid, 2);
        Integer cont1 = multipleList.size();
        request.getSession().setAttribute("multiple", multipleList);
        model.addAttribute("multiple", multipleList);
        model.addAttribute("cont1", cont1);
        Exam exam = examDao.findByEid(eid);
        model.addAttribute("exam", exam);
        return "student/papers";
    }


    /**
     * 试卷成绩
     */
    @RequestMapping("/PaperScore")
    private String PaperScore(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(true);
        Integer classid = (Integer) session.getAttribute("classid");
        Integer userid = (Integer) session.getAttribute("userid");
        List<Paper> slist = (List<Paper>) session.getAttribute("single");
        List<Paper> mlist = (List<Paper>) session.getAttribute("multiple");
        //成绩
        int eid = Integer.parseInt(request.getParameter("eid"));
        Exam byEid = examDao.findByEid(eid);
        int singlescore = byEid.getSinglecore();
        int multiplecore = byEid.getMultiplecore();
        String stuAnsArr[] = null;
        int score = 0;
        for (Paper paper : slist) {
            //获取学生每道题的答案
            stuAnsArr = request.getParameterValues(String.valueOf(paper.getSid()));
            // 单选判题
            if (stuAnsArr != null) {
                //学生每道题的答案
                String studentkeys = stuAnsArr[0];
                if (studentkeys.equalsIgnoreCase(paper.getSkey())) {
                    score = score + singlescore;
                }
            } else {
                System.out.println("提交失败！");
            }
        }
        for (Paper paper : mlist) {
            //获取每道题的答案
            stuAnsArr = request.getParameterValues(String.valueOf(paper.getSid()));
            // 多选判题
            if (stuAnsArr != null) {
                //每道题的答案
                StringBuilder studentkeys = new StringBuilder();
                //多选题拥有多个答案
                for (String s : stuAnsArr) {
                    //组装学生答案
                    studentkeys.append(s);
                }
                if (studentkeys.toString().equalsIgnoreCase(paper.getSkey())) {
                    score = score + multiplecore;
                }
            } else {
                System.out.println("提交失败！");
            }
        }
        int zscore = slist.size() * singlescore + mlist.size() * multiplecore;
        String pname = request.getParameter("pname");
        String tjtime = request.getParameter("tjtime");
        model.addAttribute("score", score);
        Studentexam studentexam = new Studentexam();
        studentexam.setEid(eid);
        studentexam.setPname(pname);
        studentexam.setUserid(userid);
        studentexam.setClassid(classid);
        studentexam.setZscore(zscore);
        studentexam.setScore(score);
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        try {
            ts = Timestamp.valueOf(tjtime);
            System.out.println(ts);
        } catch (Exception e) {
            System.out.println("时间格式错误" + e.getMessage());
        }
        studentexam.setTjtime(ts);
        studentexamDao.save(studentexam);
        //答卷表
        int seid = studentexam.getSeid();
        // 单选答卷
        for (Paper paper : slist) {
            //获取每道题的答案
            stuAnsArr = request.getParameterValues(String.valueOf(paper.getSid()));
            if (stuAnsArr != null) {
                //每道题的答案
                String studentkeys = stuAnsArr[0];
                Studentsubject studentsubject = new Studentsubject();
                studentsubject.setSeid(seid);
                studentsubject.setUserid(userid);
                studentsubject.setEid(eid);
                studentsubject.setSid(paper.getSid());
                studentsubject.setStudentkey(studentkeys);
                studentsubjectDao.save(studentsubject);
            }
        }
        // 多选答卷
        for (Paper paper : mlist) {
            //获取每道题的答案
            stuAnsArr = request.getParameterValues(String.valueOf(paper.getSid()));
            //如果是多选题，存在多个选项值，因此需要getParameterValues方法获取多个值
            if (stuAnsArr != null) {
                //每道题的答案
                StringBuilder studentkeys = new StringBuilder();
                //多选题拥有多个答案
                for (String s : stuAnsArr) {
                    //组装学生答案
                    studentkeys.append(s);
                }
                Studentsubject studentsubject = new Studentsubject();
                studentsubject.setSeid(seid);
                studentsubject.setUserid(userid);
                studentsubject.setEid(eid);
                studentsubject.setSid(paper.getSid());
                studentsubject.setStudentkey(studentkeys.toString());
                studentsubjectDao.save(studentsubject);
            }
        }
        return "student/paperScore";
    }

    /**
     * 查询是否做过该试卷
     */
    @ResponseBody
    @RequestMapping("/findOneStuExam")
    private Studentexam findOneStuExam(@RequestBody Exam exam, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        Integer userid = (Integer) session.getAttribute("userid");
        return studentexamDao.findByOne(userid, exam.getEid());
    }

    /**
     * 答卷列表
     */
    @RequestMapping("/findAllStuPaper")
    private String findAllStuPaper(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        Integer userid = (Integer) session.getAttribute("userid");
        List<Studentexam> stuexamlist = studentexamDao.findByUserid(userid);
        model.addAttribute("stuexamlist", stuexamlist);
        return "student/stuPaperList";
    }

    /**
     * 答卷
     */
    @RequestMapping("/stuPaper")
    private String stuPaper(Integer seid, HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(true);
        Integer userid = (Integer) session.getAttribute("userid");
        List<Studentsubject> stuKeys = studentsubjectDao.findBySeid(userid, seid);
        for (Studentsubject studentsubject : stuKeys) {
            Subject bySid = subjectDao.findBySid(studentsubject.getSid());
            Exam byEid = examDao.findByEid(studentsubject.getEid());
            model.addAttribute("exam", byEid);
            studentsubject.setSubject(bySid);
        }
        model.addAttribute("stukeys", stuKeys);
        return "student/stuPaper";
    }

    /**
     * 查询考试是否结束
     */
    @ResponseBody
    @RequestMapping("/findBySeid")
    private Studentexam findBySeid(@RequestBody Studentexam exams) {
        return studentexamDao.findByseid(exams.getSeid());
    }

    @ResponseBody
    @RequestMapping("/findByPname")
    private Exam findByPname(@RequestBody Exam exams) {
        Exam exam = examDao.findByPname(exams.getPname());
        if (exam != null) {
            return exam;
        } else {
            return null;
        }
    }
}