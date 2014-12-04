package pl.student.dwf.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pl.student.dwf.entity.File;
import pl.student.dwf.entity.User;
import pl.student.dwf.service.FileService;
import pl.student.dwf.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private FileService fileService;
	
	@ModelAttribute("user")
	public User constructUser() {
		return new User();
	}

	@ModelAttribute("file")
	public File constructFile() {
		return new File();
	}
	
	@RequestMapping("/users")
	public String users(Model model) {
		model.addAttribute("users", userService.findAll());
		return "users";
	}
	
	@RequestMapping("/users/{id}")
	public String detail(Model model, @PathVariable int id) {
		model.addAttribute("user", userService.findOneWithFiles(id));
		return "user-detail";
	}
	
	@RequestMapping("/register")
	public String showRegister() {
		return "user-register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String doRegister(@ModelAttribute("user") User user) {
		userService.save(user);
		return "redirect:/register.html?success=true";
	}
	
	@RequestMapping("/account")
	public String account(Model model, Principal principal) {
		String name = principal.getName();
		model.addAttribute("user", userService.findOneWithFiles(name));
		return "user-detail";
	}

	@RequestMapping(value="/account", method=RequestMethod.POST)
	public String doAddFile(@ModelAttribute("file") File file, Principal principal) {
		String name = principal.getName();
		fileService.save(file, name);
		return "redirect:/account.html";
	}
}
