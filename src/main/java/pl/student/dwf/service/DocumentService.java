package pl.student.dwf.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.apache.commons.io.IOUtils;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.History;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.DocumentRepository;
import pl.student.dwf.repository.HistoryRepository;
import pl.student.dwf.repository.RoleRepository;
import pl.student.dwf.repository.UserRepository;

@Service
@Transactional
public class DocumentService {
	
	@Autowired
	private DocumentRepository documentRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private HistoryRepository historyRepository;

	public void save(Document document, String userName, MultipartFile file, Integer reciverId) {
		User userSender = userRepository.findByName(userName);
		User userReciever = userRepository.findOne(reciverId);
		String filePath = "D:\\FileIO\\" + file.getOriginalFilename();
		try {
			FileOutputStream fos = new FileOutputStream(filePath);
			fos.write(file.getBytes());
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Date date = new Date();
		document.setName(file.getOriginalFilename());
		document.setType(file.getContentType());
		document.setSender(userSender.getId());
		document.setReciever(userReciever.getId());
		document.setDate(date);		
		documentRepository.save(document);
		
		History history = new History();
		history.setDate(date);
		history.setSentPost(userSender.getFirstName() + " " + userSender.getLastName() + " sent Document: " + document.getName() + 
		" to: " + userReciever.getFirstName() + userReciever.getLastName());
		historyRepository.save(history);
	}
	
	public void edit(String userName, MultipartFile file, Integer reciverId, Integer documentId, String documentDescription) {
		User userSender = userRepository.findByName(userName);
		User userReciever = userRepository.findOne(reciverId);
		Document editedDocument = documentRepository.findById(documentId);
		String documentName = editedDocument.getName();
		String filePath = "D:\\FileIO\\" + documentName;
		String newPath = "D:\\FileIO\\" + file.getOriginalFilename();
		File oldFile = new File(filePath);
		oldFile.delete();
		try {
			FileOutputStream fos = new FileOutputStream(newPath);
			fos.write(file.getBytes());
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Date date = new Date();
		editedDocument.setName(file.getOriginalFilename());
		editedDocument.setType(file.getContentType());
		editedDocument.setSender(userSender.getId());
		editedDocument.setReciever(userReciever.getId());
		editedDocument.setDescription(documentDescription);
		editedDocument.setLastEdited(date);
		
		History history = new History();
		history.setDate(date);
		history.setEditPost(userSender.getFirstName() + " " + userSender.getLastName() + " edited Document: " + editedDocument.getName() + 
		" and sent it to: " + userReciever.getFirstName() + " " + userReciever.getLastName());
		historyRepository.save(history);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void editByAdmin(MultipartFile file, Integer reciverId, Integer documentId, String documentDescription) {
		User userReciever = userRepository.findOne(reciverId);
		Document editedDocument = documentRepository.findById(documentId);
		Integer senderId = editedDocument.getSender();
		User userSender = userRepository.findOne(senderId);
		String documentName = editedDocument.getName();
		String filePath = "D:\\FileIO\\" + documentName;
		String newPath = "D:\\FileIO\\" + file.getOriginalFilename();
		File oldFile = new File(filePath);
		oldFile.delete();
		try {
			FileOutputStream fos = new FileOutputStream(newPath);
			fos.write(file.getBytes());
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Date date = new Date();
		editedDocument.setName(file.getOriginalFilename());
		editedDocument.setType(file.getContentType());
		editedDocument.setSender(senderId);
		editedDocument.setReciever(reciverId);
		editedDocument.setDescription(documentDescription);
		editedDocument.setLastEdited(date);
		
		History history = new History();
		history.setDate(date);
		history.setEditPost("admin" + " edited Document: " + editedDocument.getName() + " of User: " + 
		userSender.getFirstName() + " " + userSender.getLastName() +
		" and sent it to: " + userReciever.getFirstName() + userReciever.getLastName());
		historyRepository.save(history);
	}
	
	public void download(Document document, HttpServletResponse response) {
		
        try {
        	response.setContentType(document.getType());
            response.setHeader("Content-Disposition", "attachment;filename=\"" +document.getName()+ "\"");
            OutputStream out = response.getOutputStream();
            String filePath = "D:\\FileIO\\" + document.getName();
            FileInputStream in = new FileInputStream(filePath);
            IOUtils.copy(in, out);
            out.flush();
            out.close();
         
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	public void delete(Document document, String userName) {
		String filePath = "D:\\FileIO\\" + document.getName();
		File file = new File(filePath);
		file.delete();
		documentRepository.delete(document);
		
		User user = userRepository.findByName(userName);
		
		History history = new History();
		history.setDate(new Date());
		history.setDeletePost(user.getFirstName() + " " + user.getLastName() + " deleted Document: " + document.getName());
		historyRepository.save(history);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void deleteByAdmin(Document document, String userName) {
		String filePath = "D:\\FileIO\\" + document.getName();
		File file = new File(filePath);
		file.delete();
		documentRepository.delete(document);
		
		User user = userRepository.findByName(userName);
		
		History history = new History();
		history.setDate(new Date());
		history.setDeletePost("admin" + " deleted Document: " + document.getName() + " of User: " + 
		user.getFirstName() + " " + user.getLastName());
		historyRepository.save(history);
	}

	public Document findOne(int id) {
		return documentRepository.findOne(id);
	}
}
