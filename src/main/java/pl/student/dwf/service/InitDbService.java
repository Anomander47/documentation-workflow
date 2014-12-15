package pl.student.dwf.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.DocumentRepository;
import pl.student.dwf.repository.RoleRepository;
import pl.student.dwf.repository.UserRepository;

@Transactional
@Service
public class InitDbService {
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private DocumentRepository fileRepository;
	
	@PostConstruct
	public void init() {
		
		Role roleUser = new Role();
		roleUser.setName("ROLE_USER");
		roleRepository.save(roleUser);
		
		Role roleAdmin = new Role();
		roleAdmin.setName("ROLE_ADMIN");
		roleRepository.save(roleAdmin);
		
		User userAdmin = new User();
		userAdmin.setEnabled(true);
		userAdmin.setName("admin");
		userAdmin.setFirstName("John");
		userAdmin.setLastName("Admin");
		userAdmin.setEmail("AdminJohn@gmail.com");
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		userAdmin.setPassword(encoder.encode("admin"));
		List<Role> roles = new ArrayList<Role>();
		roles.add(roleAdmin);
		roles.add(roleUser);
		userAdmin.setRoles(roles);
		new File("D:\\FileIO\\" + userAdmin.getName()).mkdir();
		userRepository.save(userAdmin);
		
		User userTest = new User();
		userTest.setEnabled(true);
		userTest.setName("mike");
		userTest.setFirstName("Mike");
		userTest.setLastName("Test");
		userTest.setEmail("MikeTest@gmail.com");
		BCryptPasswordEncoder encoder2 = new BCryptPasswordEncoder();
		userTest.setPassword(encoder2.encode("admin"));
		List<Role> roles2 = new ArrayList<Role>();
		roles2.add(roleUser);
		userTest.setRoles(roles2);
		new File("D:\\FileIO\\" + userTest.getName()).mkdir();
		userRepository.save(userTest);
		
		Document fileHolder = new Document();
		List<User> users = new ArrayList<User>();
		users.add(userAdmin);
		users.add(userTest);
		fileHolder.setName("testFile");
		fileHolder.setType("application/pdf");
		fileHolder.setDate(new Date());
		fileHolder.setSender(userAdmin.getId());
		fileHolder.setReciever(2);
		fileHolder.setUsers(users);
		fileRepository.save(fileHolder);
		
		Document fileHolder2 = new Document();
		fileHolder2.setName("testFile2");
		fileHolder2.setType("text/plain");
		fileHolder2.setDate(new Date());
		fileHolder2.setSender(userAdmin.getId());
		fileHolder2.setReciever(1);
		fileHolder2.setUsers(users);
		fileHolder2.setEditable(true);
		fileRepository.save(fileHolder2);
	}
	
}
