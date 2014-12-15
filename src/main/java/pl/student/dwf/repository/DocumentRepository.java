package pl.student.dwf.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import pl.student.dwf.entity.Document;
import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;

public interface DocumentRepository extends JpaRepository<Document, Integer> {
	
	List<Document> findBySender(Integer sender, Pageable pageable );

	Document findById(Integer id);

	//List<Document> findByReciever(String sender, PageRequest pageRequest);
	List<Document> findByReciever(Integer reciever, Pageable pageable );
	
	

}
