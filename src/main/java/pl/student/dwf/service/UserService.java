package pl.student.dwf.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.File;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.FileRepository;
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
	private FileRepository fileRepository;
	
	public List<User> findAll() {
		return userRepository.findAll();
	}

	public User findOne(int id) {
		return userRepository.findOne(id);
	}

	@Transactional
	public User findOneWithFiles(int id) {
		User user = findOne(id);
		String sender = user.getName();
		List<File> files = fileRepository.findBySender(sender, new PageRequest(0, 10, Direction.DESC, "date"));
		user.setFiles(files);
		return user;
	}

	public void save(User user) {
		user.setEnabled(true);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(user.getPassword()));
		
		List<Role> roles = new ArrayList<Role>();
		roles.add(roleRepository.findByName("ROLE_USER"));
		user.setRoles(roles);
		
		userRepository.save(user);
		
	}

	public User findOneWithFiles(String name) {
		User user = userRepository.findByName(name);
		return findOneWithFiles(user.getId());
	}
}
