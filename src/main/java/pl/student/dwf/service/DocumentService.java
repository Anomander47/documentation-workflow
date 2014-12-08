package pl.student.dwf.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Blob;
import java.util.Date;

import javax.transaction.Transactional;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.DocumentRepository;
import pl.student.dwf.repository.UserRepository;

@Service
@Transactional
public class DocumentService {
	
	@Autowired
	private DocumentRepository documentRepository;
	
	@Autowired
	private UserRepository userRepository;

	public void save(Document document, String userName, MultipartFile file) {
		User user = userRepository.findByName(userName);
		try {
			document.setContent(file.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		document.setType(file.getContentType());
		document.setSender(user.getName());
		document.setDate(new Date());		
		documentRepository.save(document);
		
	}

	@PreAuthorize("#document.sender == authentication.name or hasRole('ROLE_ADMIN')")
	public void delete(@P("document") Document document) {
		documentRepository.delete(document);
	}

	public Document findOne(int id) {
		return documentRepository.findOne(id);
	}
}
