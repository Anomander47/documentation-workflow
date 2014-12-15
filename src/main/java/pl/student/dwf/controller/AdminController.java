package pl.student.dwf.controller;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.User;
import pl.student.dwf.service.DocumentService;
import pl.student.dwf.service.UserService;

@Controller
@RequestMapping("/users")
public class AdminController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DocumentService documentService;
	
	@ModelAttribute("editUser")
	public User editUser() {
		return new User();
	}

	@RequestMapping
	public String users(Model model) {
		model.addAttribute("users", userService.findAll());
		return "users";
	}
	
	@RequestMapping("/{id}")
	public String detail(Model model, @PathVariable int id) {
		model.addAttribute("user", userService.findOneWithDocuments(id));
		model.addAttribute("users", userService.findAll());
		return "user-detail";
	}
	
	@RequestMapping("/disable/{id}")
	public String disableUser(@PathVariable int id) {
		userService.disable(id);
		return "redirect:/users.html";
	}
	
	@RequestMapping("/enable/{id}")
	public String enableUser(@PathVariable int id) {
		userService.enable(id);
		return "redirect:/users.html";
	}
	
	@RequestMapping("/document/removeByAdmin/{userId}/{id}")
	public String removeDocumentByAdmin(@PathVariable int userId, @PathVariable int id) {
		Document document = documentService.findOne(id);
		String userName = userService.findOne(userId).getName();
		documentService.deleteByAdmin(document, userName);
		return "redirect:/users/" + userId +".html?success=true";
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String editUser(@PathVariable int id, Model model, @ModelAttribute("editUser") User user,
    		BindingResult result) {
		String oldUserName = userService.findOne(id).getName();
		userService.edit(user, oldUserName);
        return "redirect:/users/" + id +".html";
    }
}
