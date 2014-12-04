package pl.student.dwf.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.File;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.FileRepository;
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
	private FileRepository fileRepository;
	
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
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		userAdmin.setPassword(encoder.encode("admin"));
		List<Role> roles = new ArrayList<Role>();
		roles.add(roleAdmin);
		roles.add(roleUser);
		userAdmin.setRoles(roles);
		userRepository.save(userAdmin);
		
		File fileHolder = new File();
		List<User> users = new ArrayList<User>();
		users.add(userAdmin);
		fileHolder.setName("testFile");
		fileHolder.setType("pdf");
		fileHolder.setDate(new Date());
		fileHolder.setSender(userAdmin.getName());
		fileHolder.setReciever("Mark");
		fileHolder.setUsers(users);
		fileRepository.save(fileHolder);
	}
	
}
