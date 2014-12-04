package pl.student.dwf.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pl.student.dwf.entity.File;
import pl.student.dwf.entity.User;
import pl.student.dwf.repository.FileRepository;
import pl.student.dwf.repository.UserRepository;

@Service
public class FileService {
	
	@Autowired
	private FileRepository fileRepository;
	
	@Autowired
	private UserRepository userRepository;

	public void save(File file, String name) {
		User user = userRepository.findByName(name);
		file.setSender(user.getName());
		file.setDate(new Date());
		fileRepository.save(file);
		
	}
}
