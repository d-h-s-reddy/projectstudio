package com.pennant.propertystudio.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.pennant.propertystudio.models.CustomerUser;
import java.util.List;
import java.util.Optional;


@Repository
public interface CustomerUserRepository extends JpaRepository<CustomerUser, Long>{
	Optional<CustomerUser> findByEmail(String email);
}
