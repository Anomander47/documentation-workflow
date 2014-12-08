package pl.student.dwf.controller;

import java.security.Principal;
import java.sql.Blob;

import javax.validation.Valid;

import org.apache.commons.fileupload.UploadContext;
import org.hibernate.Hibernate;
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
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DocumentService documentService;
	
	@ModelAttribute("document")
	public Document constructDocument() {
		return new Document();
	}
	
	@RequestMapping("/account")
	public String account(Model model, Principal principal) {
		String name = principal.getName();
		model.addAttribute("user", userService.findOneWithDocuments(name));
		return "account";
	}
	
	@RequestMapping(value = "/account", method = RequestMethod.POST)
    public String doAddDocument(Model model, @Valid @ModelAttribute("document") Document document,
    		BindingResult result, @RequestParam("file") MultipartFile file, Principal principal) {
		if (result.hasErrors()) {
			return account(model, principal);
		} 
        if (!file.isEmpty()) {
        	String userName = principal.getName();
        	documentService.save(document, userName, file);
            return "redirect:account.html";
        }
        return "redirect:/account.html?fail=true";
    }
	
	@RequestMapping("/document/remove/{id}")
	public String removeDocument(@PathVariable int id) {
		Document document = documentService.findOne(id);
		documentService.delete(document);
		return "redirect:/account.html?success=true";
	}
	
}
