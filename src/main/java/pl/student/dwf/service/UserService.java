package pl.student.dwf.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.DocumentRepository;
import pl.student.dwf.repository.RoleRepository;
import pl.student.dwf.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private DocumentRepository documentRepository;
	
	public List<User> findAll() {
		return userRepository.findAll();
	}

	public User findOne(int id) {
		return userRepository.findOne(id);
	}

	@Transactional
	public User findOneWithDocuments(int id) {
		User user = findOne(id);
		Integer sender = user.getId();
		Integer reciever = user.getId();
		List<Document> documents = documentRepository.findBySender(sender, new PageRequest(0, 10, Direction.DESC, "date"));
		user.setDocuments(documents);
		List<Document> documentsToMe = documentRepository.findByReciever(reciever, new PageRequest(0, 10, Direction.DESC, "date"));
		user.setDocumentstoMe(documentsToMe);
		return user;
	}

	public void save(User user) {
		user.setEnabled(true);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(user.getPassword()));
		
		List<Role> roles = new ArrayList<Role>();
		roles.add(roleRepository.findByName("ROLE_USER"));
		user.setRoles(roles);
		
		new File("D:\\FileIO\\" + user.getName()).mkdir();
		
		userRepository.save(user);
		
	}
	
	public void edit(User user, String oldUserName) {
		user.setEnabled(true);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(user.getPassword()));
		
		List<Role> roles = new ArrayList<Role>();
		roles.add(roleRepository.findByName("ROLE_USER"));
		user.setRoles(roles);
		File oldFolder = new File("D:\\FileIO\\" + oldUserName);
		File newFolder = new File("D:\\FileIO\\" + user.getName());
		oldFolder.renameTo(newFolder);
		
		userRepository.save(user);
		
	}

	public User findOneWithDocuments(String name) {
		User user = userRepository.findByName(name);
		return findOneWithDocuments(user.getId());
	}

	public void disable(int id) {
		User user = userRepository.findOne(id);
		user.setEnabled(false);
	}
	
	public void enable(int id) {
		User user = userRepository.findOne(id);
		user.setEnabled(true);
	}

	public User findOne(String username) {
		return userRepository.findByName(username);
	}

}
