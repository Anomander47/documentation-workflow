package pl.student.dwf.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import pl.student.dwf.entity.File;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;

public interface FileRepository extends JpaRepository<File, Integer> {
	
	List<File> findBySender(String sender, Pageable pageable );

}
