package pl.student.dwf.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByName(String name);

}
