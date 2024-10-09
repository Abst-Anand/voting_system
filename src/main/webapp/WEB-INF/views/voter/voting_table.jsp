<%@ page import="com.votingSystem.entity.Candidate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.votingSystem.entity.User" %>
<%@ page import="com.votingSystem.entity.Election" %><%--
  Created by IntelliJ IDEA.
  User: araaz
  Date: 07-10-2024
  Time: 19:37
  To change this template use File | Settings | File Templates.
--%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/confirmation.css">

    <style>
        .party-logo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ccc;
        }
    </style>

    <script>
        function confirmAction(actionUrl) {
            const modal = document.getElementById('confirmationModal');
            modal.style.display = 'block';

            document.getElementById('confirmButton').onclick = function () {
                // If confirmed, execute the action and refresh the main page
                window.top.location.href = actionUrl;
            };

            document.getElementById('cancelButton').onclick = function () {
                // If canceled, close the modal and do nothing
                modal.style.display = 'none';
            };
        }
    </script>

</head>
<body>
<%!
    String cloudinaryPrefix = "https://res.cloudinary.com/dl1hqxniz/image/upload/v1727458264/";
%>

<%
    User currentUser = (User) request.getAttribute("currentUser");
    Map<Integer, String> lsElections = (Map<Integer, String> ) request.getAttribute("lokSabhaElections");
    List<Candidate> lsCandidates = (List<Candidate>) request.getAttribute("lokSabhaCandidates");

    Map<Integer, String> rsElections = (Map<Integer, String> ) request.getAttribute("rajyaSabhaElections");
    List<Candidate> rsCandidates = (List<Candidate>) request.getAttribute("rajyaSabhaCandidates");

    Map<Integer, String> mnElections = (Map<Integer, String> ) request.getAttribute("municipalElections");
    List<Candidate> mnCandidates = (List<Candidate>) request.getAttribute("municipalCorpCandidates");

    Map<Integer,String> allImages = (Map<Integer,String>) request.getAttribute("allPartyLogo");

%>


<h2 style="color: black">Lok Sabha Elections</h2>
<table>

    <thead>
    <tr>
        <th>Candidate Name</th>
        <th>Election Name</th>
        <th>Party Name</th>
        <th>Party Symbol</th>
        <th>Vote</th>

    </tr>
    </thead>
    <tbody>
    <%

        if (!lsCandidates.isEmpty()){
            for(Candidate candidate : lsCandidates){
                String logoPublicId = allImages.get(candidate.getPartyLogoId());
                String imgSource = cloudinaryPrefix + logoPublicId;

    %>
    <tr>

        <td> <%=candidate.getCandidateName() %> </td>
        <td> <%=lsElections.get(candidate.getElectionId()) %> </td>
        <td> <%=candidate.getPartyName() %> </td>
        <td> <img class="party-logo" src="<%= imgSource%>" alt="Party Logo"> </td>

        <td class="action-icons">
            <button class="icon-button" title="Vote <%=candidate.getPartyName()%>" onclick="confirmAction('/voter/voting?voterId=<%=currentUser.getUserId()%>&electionId=<%=candidate.getElectionId()%>&candidateId=<%=candidate.getCandidateId()%>')">
                <i class="fa-solid fa-check-to-slot"></i>
            </button>
        </td>


    </tr>



    <%
            }
        }
    %>

    </tbody>
</table>


<h2 style="color: black">Rajya Sabha Elections</h2>
<table>

    <thead>
    <tr>
        <th>Candidate Name</th>
        <th>Election Name</th>
        <th>Party Name</th>
        <th>Party Symbol</th>
        <th>Vote</th>

    </tr>
    </thead>
    <tbody>
    <%

        if (!lsCandidates.isEmpty()){
            for(Candidate candidate : rsCandidates){
                String logoPublicId = allImages.get(candidate.getPartyLogoId());
                String imgSource = cloudinaryPrefix + logoPublicId;

    %>
    <tr>

        <td> <%=candidate.getCandidateName() %> </td>
        <td> <%=rsElections.get(candidate.getElectionId()) %> </td>
        <td> <%=candidate.getPartyName() %> </td>
        <td> <img class="party-logo" src="<%= imgSource%>" alt="Party Logo"> </td>

        <td class="action-icons">
            <button class="icon-button" title="Vote <%=candidate.getPartyName()%>" onclick="confirmAction('/voter/voting?voterId=<%=currentUser.getUserId()%>&electionId=<%=candidate.getElectionId()%>&candidateId=<%=candidate.getCandidateId()%>')">
                <i class="fa-solid fa-check-to-slot"></i>
            </button>
        </td>


    </tr>



    <%
            }
        }
    %>

    </tbody>
</table>


<h2 style="color: black">Municipal Corporation Elections</h2>
<table>

    <thead>
    <tr>
        <th>Candidate Name</th>
        <th>Election Name</th>
        <th>Party Name</th>
        <th>Party Symbol</th>
        <th>Vote</th>

    </tr>
    </thead>
    <tbody>
    <%

        if (!lsCandidates.isEmpty()){
            for(Candidate candidate : mnCandidates){
                String logoPublicId = allImages.get(candidate.getPartyLogoId());
                String imgSource = cloudinaryPrefix + logoPublicId;

    %>
    <tr>

        <td> <%=candidate.getCandidateName() %> </td>
        <td> <%=mnElections.get(candidate.getElectionId()) %> </td>
        <td> <%=candidate.getPartyName() %> </td>
        <td> <img class="party-logo" src="<%= imgSource%>" alt="Party Logo"> </td>

        <td class="action-icons">
            <button class="icon-button" title="Vote <%=candidate.getPartyName()%>" onclick="confirmAction('/voter/voting?voterId=<%=currentUser.getUserId()%>&electionId=<%=candidate.getElectionId()%>&candidateId=<%=candidate.getCandidateId()%>')">
                <i class="fa-solid fa-check-to-slot"></i>
            </button>
        </td>


    </tr>



    <%
            }
        }
    %>

    </tbody>
</table>


<!-- Confirmation Modal -->
<div id="confirmationModal" class="modal" style="display: none">
    <div class="modal-content">
        <h3>Are you sure you want to proceed?</h3>
        <div class="button-container">
            <button class="btn-warning" id="cancelButton">Cancel</button>
            <button class="btn-cancel" id="confirmButton">Confirm</button>
        </div>
    </div>
</div>


</body>
</html>