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
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.DocumentRepository;
import pl.student.dwf.repository.RoleRepository;
import pl.student.dwf.repository.UserRepository;

@Service
@Transactional
public class DocumentService {
	
	@Autowired
	private DocumentRepository documentRepository;
	
	@Autowired
	private UserRepository userRepository;

	public void save(Document document, String userName, MultipartFile file, Integer reciverId) {
		User user = userRepository.findByName(userName);
		String filePath = "D:\\FileIO\\" + userName + "\\" + file.getOriginalFilename();
		try {
			FileOutputStream fos = new FileOutputStream(filePath);
			fos.write(file.getBytes());
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		document.setName(file.getOriginalFilename());
		document.setType(file.getContentType());
		document.setSender(user.getId());
		document.setReciever(reciverId);
		document.setDate(new Date());		
		documentRepository.save(document);
	}
	
	public void download(Document document, HttpServletResponse response) {
		
        try {
        	response.setContentType(document.getType());
            response.setHeader("Content-Disposition", "attachment;filename=\"" +document.getName()+ "\"");
            OutputStream out = response.getOutputStream();
            String filePath = "D:\\FileIO\\" + userRepository.findOne(document.getSender()).getName() + "\\" + document.getName();
            FileInputStream in = new FileInputStream(filePath);
            IOUtils.toByteArray(in);
            IOUtils.copy(in, out);
            out.flush();
            out.close();
         
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	public void delete(Document document, String userName) {
		String filePath = "D:\\FileIO\\" + userName + "\\" + document.getName();
		File file = new File(filePath);
		file.delete();
		documentRepository.delete(document);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void deleteByAdmin(Document document, String userName) {
		String filePath = "D:\\FileIO\\" + userName + "\\" + document.getName();
		File file = new File(filePath);
		file.delete();
		documentRepository.delete(document);
	}

	public Document findOne(int id) {
		return documentRepository.findOne(id);
	}
}
