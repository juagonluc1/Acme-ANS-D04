<%--
- input-textarea.tag
-
- Copyright (C) 2012-2025 Rafael Corchuelo.
-
- In keeping with the traditional purpose of furthering education and research, it is
- the policy of the copyright owner to permit non-commercial use and redistribution of
- this software. It has been tested carefully, but it is not guaranteed for any particular
- purposes.  The copyright owner does not offer any warranties or representations, nor do
- they accept any liabilities with respect to them.
--%>

<%@tag body-content="empty"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="acme" uri="http://acme-framework.org/"%>

<%@attribute name="path" required="true" type="java.lang.String"%>
<%@attribute name="code" required="true" type="java.lang.String"%>
<%@attribute name="placeholder" required="false" type="java.lang.String"%>
<%@attribute name="readonly" required="false" type="java.lang.Boolean"%>

<jstl:if test="${placeholder == null}">
	<jstl:set var="placeholder" value="acme.default.placeholder.textarea"/>	
</jstl:if>

<jstl:if test="${readonly == null}">
	<jstl:set var="readonly" value="false"/>
</jstl:if>

<jstl:if test="${readonly}">
	<acme:print var="$hint" value=""/>
</jstl:if>
<jstl:if test="${!readonly}">
	<acme:print var="$hint" code="${placeholder}"/>
</jstl:if>

<div class="form-group">
	<label for="${path}">
		<acme:print code="${code}"/>
	</label>
	<!--  HINT: can't use acme:print inside a textaera since blanks matter! Thus, the 
		  HINT+ value must be extracted and printed using an ancillary variable.
	 -->
	<jstl:set var="path_text" value="${path}$text"/>
	<acme:print var="${path_text}" value="${requestScope[path]}"/>	
    <textarea id="${path}" name="${path}" class="form-control" placeholder="${$hint}" <jstl:if test="${readonly}">readonly</jstl:if>><jstl:out value="${requestScope[path_text]}"/></textarea>
	<acme:show-errors path="${path}"/>
</div>

