package com.votingSystem.controller;

import com.votingSystem.entity.*;
import com.votingSystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/voter")
public class VoteController {

    @Autowired
    private ElectionService electionService;

    @Autowired
    private CandidateService candidateService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private ElectionParticipantsService electionParticipantsService;

    @Autowired
    private VoteService voteService;

    @Autowired
    private JwtService jwtService;


    @GetMapping("/info")
    public String info(Model model) {

        User currentUser = jwtService.getCurrentUser();

        List<Election> lokSabhaElections = electionService.getAllLokSabhaElections();
        List<Election> rajyaSabhaElections = electionService.getAllRajyaSabhaElections();
        List<Election> municipalElections = electionService.getAllMunicipalElections();

        // lok sabha information
        List<Candidate> lsCandidates = new ArrayList<>();
        Map<Integer, String> lsElections = new HashMap<>();

        // rajya sabha information
        List<Candidate> rsCandidates = new ArrayList<>();
        Map<Integer, String> rsElections = new HashMap<>();

        // municipal corporation information
        List<Candidate> mnCandidates = new ArrayList<>();
        Map<Integer, String> mnElections = new HashMap<>();


        // Get All Elections Category Wise
        for (Election election : lokSabhaElections) {
            lsElections.put(election.getElectionId(), election.getElectionName());
        }

        for (Election election : rajyaSabhaElections) {
            rsElections.put(election.getElectionId(), election.getElectionName());
        }

        for (Election election : municipalElections) {
            mnElections.put(election.getElectionId(), election.getElectionName());
        }

        model.addAttribute("lokSabhaElections", lsElections);
        model.addAttribute("rajyaSabhaElections", rsElections);
        model.addAttribute("municipalElections", mnElections);

        // Get Candidates in each of the above elections
        for (Election election : lokSabhaElections) {
            int electionId = election.getElectionId();
            if (!voteService.hasVoted(currentUser.getUserId(), electionId)) {
                List<Candidate> temp = electionParticipantsService.getCandidatesByElectionId(electionId);
                lsCandidates.addAll(temp);
            }
        }

        for (Election election : rajyaSabhaElections) {
            if (!voteService.hasVoted(currentUser.getUserId(), election.getElectionId())) {
                rsCandidates.addAll(electionParticipantsService.getCandidatesByElectionId(election.getElectionId()));
            }
        }

        for (Election election : municipalElections) {
            if (!voteService.hasVoted(currentUser.getUserId(), election.getElectionId())) {
                mnCandidates.addAll(electionParticipantsService.getCandidatesByElectionId(election.getElectionId()));
            }
        }

        model.addAttribute("lokSabhaCandidates", lsCandidates);
        model.addAttribute("rajyaSabhaCandidates", rsCandidates);
        model.addAttribute("municipalCorpCandidates", mnCandidates);


        // To get image URLs from images table
        List<Candidate> allCandidates = candidateService.findAllCandidates();
        Map<Integer, String> partyLogo = new HashMap<Integer, String>();

        for (Candidate candidate : allCandidates) {
            Image image = imageService.getImage(candidate.getPartyLogoId());
            partyLogo.put(candidate.getPartyLogoId(), image.getImageUrl());
        }

        model.addAttribute("allPartyLogo", partyLogo);
        model.addAttribute("currentUser", currentUser);

        return "voter/voting_table";
    }

    @GetMapping("/voting")
    public String voting(@RequestParam("voterId") int voterId, @RequestParam("electionId") int electionId, @RequestParam("candidateId") int candidateId, Model model) {

        System.out.println("voterId = " + voterId);
        System.out.println("electionId = " + electionId);
        System.out.println("candidateId = " + candidateId);

        Vote vote = new Vote(voterId, electionId, candidateId);


        int voteCountStatus = candidateService.incrementVoteCount(candidateId);

        int result = voteService.saveVote(vote);


        if (result == 1 && voteCountStatus == 1) {
            System.out.println("Voted Successfully");
        } else {
            System.out.println("Voted Failed");
        }

        return "hdh";


    }

}
