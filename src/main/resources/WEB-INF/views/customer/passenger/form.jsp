<%--
- form.jsp
-
- Copyright (C) 2012-2025 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non-commercial use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@page%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" uri="http://acme-framework.org/"%>

<acme:form> 
		<acme:input-textbox code="customer.passenger.list.label.fullName" path="fullName"/>  
		<acme:input-email code="customer.passenger.list.label.email" path="email"/>  
		<acme:input-textbox code="customer.passenger.list.label.passportNumber" path="passportNumber"/>  
		<acme:input-moment code="customer.passenger.list.label.birthDate" path="birthDate"/>  
		<acme:input-textbox code="customer.passenger.list.label.specialNeeds" path="specialNeeds"/>  
		
	<jstl:choose>
		<jstl:when test="${acme:anyOf(_command, 'show|update|publish|delete') && draftMode == true}">
			<acme:submit code="customer.passenger.form.button.update" action="/customer/passenger/update"/>
 			<acme:submit code="customer.passenger.form.button.publish" action="/customer/passenger/publish"/>
 			<acme:submit code="customer.passenger.form.button.delete" action="/customer/passenger/delete"/>
		</jstl:when>
		<jstl:when test="${_command == 'create'}">
			<acme:submit code="customer.passenger.form.button.create" action="/customer/passenger/create"/>
		</jstl:when>		
	</jstl:choose>	
		 		
</acme:form>