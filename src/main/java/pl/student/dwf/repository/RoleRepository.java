package pl.student.dwf.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.student.dwf.entity.Role;
import pl.student.dwf.entity.User;

public interface RoleRepository extends JpaRepository<Role, Integer> {

	Role findByName(String name);

}
