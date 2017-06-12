dom = React.DOM 

@Terms = React.createClass
	displayName: 'Terms and Conditions'
	getDefaultProps:->
		terms: '<p align="justify"><span style="font-family: Calibri, serif;"><em>By applying for a SASensei Account you are agreeing to be bound by these Terms of Use. Please read them carefully, and in particular clause 3 (User Content) and clause 6 (Warranties). If you do not agree to any of the terms set out in these Terms of Use, then please do not apply for SASensei Account.</em></span></p>
<p>&nbsp;</p>
<p><span style="font-family: Calibri, serif;"><strong>1. Definitions and Interpretation</strong></span></p>
<p><span style="font-family: Calibri, serif;">1.1 Except to the extent expressly provided otherwise, in these Terms of Use and in a User Application:</span></p>
<p>&nbsp;</p>
<dl><dd>
<table style="width: 576px;" cellspacing="0" cellpadding="7"><colgroup><col width="154" /> <col width="391" /> </colgroup>
<tbody>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>Business Days</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">Mondays to Fridays, excluding English Bank and public holidays.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>Data Protection Laws</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the EU Data Protection Directive (Directive 95/46/EC), the Data Protection Act 1998 and Electronic Communications (EC Directive) Regulations 2003 and any other data protection laws and regulations, orders and any codes of practice, guidelines and recommendations issued by the Information Commissioner&rsquo;s Office or any replacement or equivalent body, as amended and in force from time to time.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p><span style="font-family: Calibri, serif;">"</span><span style="font-family: Calibri, serif;"><strong>Force Majeure Event</strong></span><span style="font-family: Calibri, serif;">"</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">an event, or a series of related events, that is outside the reasonable control of the party affected (including failures of the internet or any public telecommunications network, hacker attacks, denial of service attacks, virus or other malicious software attacks or infections, power failures, industrial disputes affecting any third party, changes to the law, diMacroters, explosions, fires, floods, riots, terrorist attacks and wars).</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p><span style="font-family: Calibri, serif;">"</span><span style="font-family: Calibri, serif;"><strong>Intellectual Property Rights</strong></span><span style="font-family: Calibri, serif;">"</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">all intellectual property rights wherever in the world, whether registrable or unregistrable, registered or unregistered, including any application or right of application for such rights (and these "intellectual property rights" include copyright and related rights, database rights, confidential information, trade secrets, know-how, business names, trade names, trademarks, service marks, passing off rights, unfair competition rights, patents, petty patents, utility models, semi-conductor topography rights and rights in designs).</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p><span style="font-family: Calibri, serif;">"</span><span style="font-family: Calibri, serif;"><strong>Macro People</strong></span><span style="font-family: Calibri, serif;">"</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">Macro People Ltd a company incorporated in England and Wales with registration number 10702942 and its registered office at </span><span style="color: #0b0c0c;"><span style="font-family: Calibri, serif;">29 Oldfield Road, Windermere, England, LA23 2AZ</span></span><span style="font-family: Calibri, serif;">.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>SASensei</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the tokens used to play the SASensei Game.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>SASensei Account</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means an account provided by Macro People which enables a User:</span></p>
<ul>
<li>
<p><span style="font-family: Calibri, serif;">to add basic personal details to their SASensei Site profile, including links to their social media profiles;</span></p>
</li>
<li>
<p><span style="font-family: Calibri, serif;">to play the SASensei Game; and</span></p>
</li>
</ul>
<ul>
<li>
<p><span style="font-family: Calibri, serif;">subject to achieving the necessary privilege, to add, rate, comment or approve questions on the SASensei Site.</span></p>
</li>
</ul>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>SASensei Game</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the game that Users may play on the SASensei Site, which involves demonstrating their domain experience by submitting questions, answering questions and passing tests.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>SASensei Rules</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means then-current rules relating to the awarding, use and purchase of Tokens, and the benefits associated with accruing minimum number of Tokens, which are available on the SASensei Site. The SASensei Rules may be amended from time to time by Macro People with immediate effect.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p><span style="font-family: Calibri, serif;">"</span><span style="font-family: Calibri, serif;"><strong>SASensei Site</strong></span><span style="font-family: Calibri, serif;">"</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means Macro People&rsquo;s proprietary web portal at </span><a href="http://www.macro.cards/"><span style="color: #0563c1;"><span style="font-family: Calibri, serif;"><span style="text-decoration: underline;">www.</span></span></span></a><span style="font-family: Calibri, serif;">sasensai.com that may be accessed by Users to access and use their SASensei Account.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p><span style="font-family: Calibri, serif;">"</span><span style="font-family: Calibri, serif;"><strong>Term</strong></span><span style="font-family: Calibri, serif;">"</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">unless cancelled earlier in accordance with clause 11, the period starting on the User Start Date and ending on the date on which the SASensei Account is cancelled by either the User or by Macro People.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>TOKENS</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means additional Cards purchased by a User in accordance with the SASensei Rules.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>TOKENS Charges</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the charges payable by the User for TOKENS.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>User</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the person identified as such in a User Application.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>User Application</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">an application by the User for a SASensei Account, submitted by the User using the SASensei Site.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>User Content</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means all data contributed to the SASensei Site, or otherwise provided by the User to Macro People. For the avoidance of doubt, &ldquo;User Content&rdquo; includes data that is removed by the User at any time following its publication on the SASensei Site.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>User Personal Data</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means any User Content which constitutes or includes Personal Data.</span></p>
</td>
</tr>
<tr valign="top">
<td width="154">
<p>&ldquo;<span style="font-family: Calibri, serif;"><strong>User Start Date</strong></span><span style="font-family: Calibri, serif;">&rdquo;</span></p>
</td>
<td width="391">
<p><span style="font-family: Calibri, serif;">means the date on which Macro People accepts the User Application or, if later, the date on which Macro People provides the User with log in details to enable the User to access the SASensei Site and use the SASensei Account.</span></p>
</td>
</tr>
</tbody>
</table>
</dd></dl>
<p>&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;">1.2 In these Terms of Use, a reference to a statute or statutory provision includes a reference to:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) that statute or statutory provision as modified, consolidated and/or re-enacted from time to time; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) any subordinate legislation made under that statute or statutory provision.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">1.3 The clause headings do not affect the interpretation of these Terms of Use.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">1.4 In these Terms of Use, general words shall not be given a restrictive interpretation by reason of being preceded or followed by words indicating a particular class of acts, matters or things.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">1.5 In case of an inconsistency or conflict between these Terms of Use and any provision in a User Application, the provision in the User Application prevails.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>2. SASensei Account</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">2.1 Macro People shall promptly provide to the User login details for the SASensei Site to enable the User to access and use the SASensei Account.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">2.2 Macro People grants to the User a non-exclusive licence to access and use the SASensei Account for the User&rsquo;s private, non-commercial purposes during the Term.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">2.3 The licence granted by Macro People to the User under clause 2.2 is subject to the following:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) the User must not sub-license his or her right to access and use the SASensei Account to any third party, or use the SASensei Account to provide any commercial services or any other benefit to any third party; </span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) the User shall use reasonable endeavours, including implementing reasonable security measures relating to his or her account access details, to ensure that no unauthorised person gains access to the SASensei Account;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) the User must not use the SASensei Account in any way that causes, or may cause, damage to the SASensei Site or which impairs or may impair the availability or accessibility of the SASensei Account; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(d) the User must not use the SASensei Account:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(i) in any way that is unlawful, illegal, fraudulent or harmful; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(ii) in connection with any unlawful, illegal, fraudulent or harmful purpose or activity.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">2.4 For the avoidance of doubt, the User has no right to access the software code (including object code, intermediate code and source code) of the SASensei Site, either during or after the Term.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">2.5 Macro People shall use all reasonable commercial endeavours to carry out scheduled or planned maintenance to the SASensei Site outside the hours of 09:00 - 17:00 UK time on Business Days. Macro People will give the User at least one (1) Business Day&rsquo;s prior notice of any planned maintenance that will or is likely to result in disruption to their SASensei Account, and as much notice as is reasonably practicable (if any) of any unplanned or emergency maintenance.</span></p>
<p>&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>3. User Content</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">3.1 The User grants to Macro People a non-exclusive, perpetual, irrevocable, royalty-free licence:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) to copy, reproduce, store, distribute, publish, post, remove, export, adapt, edit, translate, and to create derivate works from, the User Content;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) to aggregate the User Content with content and other data provided by other users of the SASensei Site, and to provide such aggregated data to third parties on a commercial basis; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) to authorise others to exercise the rights granted to Macro People under 3.1(a) and 3.1(b), including on a commercial basis, </span></p>
<p align="justify"><span style="font-family: Calibri, serif;">in each case throughout the world and in any form or media.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">3.2 The User agrees that Macro People may:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) review and verify any User Content, or any other information transmitted or received via the User&rsquo;s SASensei Account; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) refuse to post, amend or delete any User Content, including where Macro People considers (in its absolute discretion) that the User or the User Content is in breach of any of the warranties set out in clause 6.2.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>4. Intellectual Property Rights</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">4.1 Nothing in these Terms of Use shall operate to assign or transfer any Intellectual Property Rights from either party to the other party.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">4.2 All Intellectual Property Rights in</span> <span style="font-family: Calibri, serif;">in all materials generated or otherwise created by Macro People, solely or jointly with any person, in the course of making the SASensei Account available to the User shall vest or remain vested in Macro People.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">4.3 If Macro People reasonably determines, or any third party alleges, that the use of the SASensei Account by the User in accordance with these Terms of Use infringes any persons Intellectual Property Rights, Macro People may at its own cost and expense:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) modify the SASensei Account in such a way that they no longer infringe the relevant Intellectual Property Rights; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) procure for the User the right to use the SASensei Account in accordance with these Terms of Use; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) if neither of the options set out in (a) or (b) are commercially or technically practicable, cancel the User&rsquo;s SASensei Account and refund the User any TOKENS Charges previously paid in respect of the SASensei Account.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">4.4 Subject to Macro People&rsquo;s rights under the licence granted under clause 3, all Intellectual Property Rights in the User Content shall vest and remain vested in the User.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">4.5 The User agrees to indemnify Macro People, its officers, agents, partners and employees from any and all claims or damage, including reasonable legal fees, made by third parties due to, or arising out of the User Content, the licence granted to Macro People under clause 3, or the User&rsquo;s use of the Macro Accounts Site.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>5. TOKENS and TOKENS Charges </strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">5.1 Macro People and the User agree that:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) the provision by Macro People of TOKENS is subject to advance payment by the User of the TOKENS Charges to Macro People&rsquo;s nominated payment collection provider; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) TOKENS may not be redeemed for cash or otherwise cancelled, whether before or after the end of the Term.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>6. Warranties</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">6.1 Each party warrants to the other party that:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) it, he or she has the legal right and authority to enter into these Terms of Use and to perform their obligations under these Terms of Use; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) it, he or she will comply with all applicable legal and regulatory requirements applying to the exercise of their rights and the fulfilment of their obligations under these Terms of Use.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">6.2 The User warrants and represents to Macro People that:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) the User Content:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(i) is the User&rsquo;s own, original work, and (without limitation) is not copied or derived from the work of any third party;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(ii) is true and accurate in all respects, and not misleading; </span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(iii) is not </span><span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>abusive, vulgar, discriminatory, sexually explicit, violent, obscene, hateful, fraudulent, unlawful, threatening, harassing or defamatory or discloses private or personal matters concerning any person;</span></span></span></p>
<p align="justify"><span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>(iv) does not</span></span></span> <span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>impersonate any person or entity, include their email address or name, or falsely state or otherwise misrepresent your affiliation with anyone or entity;</span></span></span></p>
<p align="justify"><span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>(v) does not post or transmit any spam, advertising, promotional materials or other forms of solicitation;</span></span></span></p>
<p align="justify"><span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>(vi) does not post or transmit any file that contains viruses, corrupted files, Trojan Horses, keystroke loggers, time bombs, worms, spyware, adware or any contaminating or destructive features that may damage someone elses computer or affect its operation; and</span></span></span></p>
<p align="justify"><span style="color: #000000;"><span style="font-family: Calibri, serif;"><span>(vii) post or transmit any material that is in any way contrary to any applicable law or which constitutes an infringement of another persons proprietary rights or a breach of any contractual or fiduciary obligation (including the unauthorised posting or transmission of any copyright work or confidential information); and</span></span></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) the use and commercial exploitation of the User Content by Macro People in accordance with these Terms of Use will not:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(i) breach the provisions of any law, statute or regulation;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(ii) infringe the Intellectual Property Rights or other legal rights of any person; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(iii) give rise to any cause of action against Macro People,</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">in each case in any jurisdiction and under any applicable law.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">6.3 The parties warranties and representations in respect of the subject matter of these Terms of Use are expressly set out in these Terms of Use. To the maximum extent permitted by applicable law, no other warranties or representations concerning the subject matter of these Terms of Use will be implied into these Terms of Use or any related contract.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>7. Acknowledgements and warranty limitations</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">7.1 The User acknowledges that complex software is never wholly free from defects, errors and bugs; and subject to the other provisions of these Terms of Use, Macro People gives no warranty or representation that the SASensei Site or the SASensei Account will be wholly free from defects, errors and bugs.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">7.2 The User acknowledges that complex software is never entirely free from security vulnerabilities; and Macro People gives no warranty or representation that the SASensei Account will be entirely secure.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">7.3 Except to the extent expressly provided otherwise in these Terms of Use, Macro People does not warrant or represent that the use of the SASensei Account by the User will be suitable for the User&rsquo;s purposes, or will provide the User with any specific result, return on investment or other outcome.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>8. Data protection</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">8.1 Macro People and the User agree that, for the purposes of Data Protection Laws, the User is the Data Controller and Macro People is the Data Processor of the User Personal Data.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">8.2 The User warrants to Macro People that he or she has the legal right to disclose all User Personal Data that he or she does in fact disclose to Macro People under or in connection with these Terms of Use, and that the processing of that User Personal Data by Macro People in accordance with these Terms of Use will not breach any Data Protection Laws.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">8.3 Macro People will, at all times:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) carry out all processing of User Personal Data in accordance with these Terms of Use, the Privacy Policy and any written instructions received from the User from time to time; </span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) have in place appropriate technical and organisational security measures so that User Personal Data is protected against unauthorised or unlawful processing and against accidental loss, destruction or damage;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) only process the User Personal Data for the purposes of performing its obligations and exercising its rights under these Terms of Use; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(d) it will process the User Personal Data in compliance with all applicable laws.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">8.4 Macro People warrants that it will:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) promptly carry out any request from the User to amend, transfer, delete or return the User Personal Data;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) not disclose User Personal Data to any third party other than at the User&rsquo;s request, as set out in these Terms of Use, the Privacy Policy, or as required by law;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) immediately notify the User in the event of a request for disclosure of User Personal Data by a law enforcement authority or any communication from any supervisory or government body or any notice or request from an individual in relation to the User Personal Data; and </span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(d) not transfer User Personal Data outside the EEA unless it has the prior written consent of the User.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>9. Limitations and exclusions of liability</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">9.1 Nothing in these Terms of Use will:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) limit or exclude any liability for death or personal injury resulting from negligence;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) limit or exclude any liability for fraud or fraudulent misrepresentation;</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) limit any liabilities in any way that is not permitted under applicable law; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(d) exclude any liabilities that may not be excluded under applicable law.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">9.2 The limitations and exclusions of liability set out in this clause 9 and elsewhere in these Terms of Use:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) are subject to clause 9.1; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) govern all liabilities arising under these Terms of Use or relating to the subject matter of these Terms of Use, including liabilities arising in contract, in tort (including negligence) and for breach of statutory duty, except to the extent expressly provided otherwise in these Terms of Use.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">9.3 Macro People shall not be liable to the User in respect of:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) any losses arising out of a Force Majeure Event; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) any loss of profits or anticipated savings; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) any loss of revenue or income; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(d) any loss of use or production; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(e) any loss of business, contracts or opportunities; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(f) any loss or corruption of any data, database or software.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">9.4 Neither party shall be liable to the other party in respect of any special, indirect or consequential loss or damage.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">9.5 The liability of each party to the other party under these Terms of Use in respect of any event or series of related events shall not exceed the higher of:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) an amount equal to five (5) times all sums</span> <span style="font-family: Calibri, serif;">paid or payable by the User to Macro People under these Terms of Use; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) &pound;1,000.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>10. Force Majeure Event</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">10.1 If a Force Majeure Event gives rise to a failure or delay in either party performing any obligation under these Terms of Use (other than any obligation to make a payment), that obligation will be suspended for the duration of the Force Majeure Event.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">10.2 A party that becomes aware of a Force Majeure Event which gives rise to, or which is likely to give rise to, any failure or delay in that party performing any obligation under these Terms of Use, must:</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) promptly notify the other; and</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) inform the other of the period for which it is estimated that such failure or delay will continue.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">10.3 A party whose performance of its obligations under these Terms of Use is affected by a Force Majeure Event must take reasonable steps to mitigate the effects of the Force Majeure Event.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>11. Cancellation</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">11.1 The User may cancel their SASensei Account at any time, for any reason and with immediate effect.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">11.2 Macro People may cancel the User&rsquo;s SASensei Account at any time, for any reason and with immediate effect, provided that if Macro People is cancelling the SASensei Account for convenience (ie not as a result of the User&rsquo;s breach or other default), then, if so requested by the User in writing, Macro People shall refund to the User the TOKENS Charges relating to any TOKENS which were unused as at the date of cancellation..</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>12. Effects of cancellation</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">12.1 Upon the cancellation of a User Account, all of the provisions of these Terms of Use shall cease to have effect, save that the following provisions of these Terms of Use shall survive and continue to have effect (in accordance with their express terms or otherwise indefinitely): clauses 1, 3, 4, 6, 7, 9, 10, 12, 13, 16, 17, 18 and 19.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>13. Notices</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">13.1 Any notice from one party to the other party under these Terms of Use must be given by one of the following methods (using the relevant contact details set out on the SASensei Site and in clause 13.2):</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(a) delivered personally or sent by courier, in which case the notice shall be deemed to be received upon delivery; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(b) sent by recorded signed-for post, in which case the notice shall be deemed to be received two (2) Business Days following posting; or</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">(c) sent by email using, in the case of Macro People, the contact form at www.macro.cards or, in the case of the User, the email address set out in the User Application.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;"> provided that if the stated time of deemed receipt is not within Business Hours, then the time of deemed receipt shall be when Business Hours next begin after the stated time.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">13.2 Macro People&rsquo;s contact details for notices under this clause 13 are as follows:</span></p>
<p align="justify"><span style="color: #0b0c0c;"><span style="font-family: Calibri, serif;">29 Oldfield Road</span></span></p>
<p align="justify"><span style="color: #0b0c0c;"><span style="font-family: Calibri, serif;">Windermere</span></span></p>
<p align="justify"><span style="color: #0b0c0c;"><span style="font-family: Calibri, serif;">LA23 2AZ</span></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">Attn: Mr Allan Bowe</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">13.3 The addressee and contact details set out in clause 13.2 may be updated from time to time by Macro People by posting a change of address and contact details on the SASensei Site.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>14. Subcontracting</strong></span></p>
<p align="justify"><a name="_30j0zll"></a> <span style="font-family: Calibri, serif;">14.1 Macro People may subcontract any of its obligations under these Terms of Use, provided that Macro People shall remain responsible to the User for the performance of any subcontracted obligations.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>15. Assignment</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">15.1 The User must not assign, transfer or otherwise deal with his or her contractual rights and/or obligations under these Terms of Use.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>16. No waivers</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">16.1 No breach of any provision of these Terms of Use will be waived except with the express written consent of the party not in breach.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">16.2 No waiver of any breach of any provision of these Terms of Use shall be construed as a further or continuing waiver of any breach of that provision or any other provision of these Terms of Use.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>17. Severability</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">17.1 If a provision of these Terms of Use is determined by any court or other competent authority to be unlawful and/or unenforceable, the other provisions will continue in effect.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">17.2 If any unlawful and/or unenforceable provision of these Terms of Use would be lawful or enforceable if part of it were deleted, that part will be deemed to be deleted, and the rest of the provision will continue in effect.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>18. Variation</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">18.1 Macro People may vary these Terms of Use by posting revised Terms of Use on the SASensei Site. It is the User&rsquo;s responsibility to check the SASensei Site for any changes to these Terms of Use.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify"><span style="font-family: Calibri, serif;"><strong>19. Law and jurisdiction</strong></span></p>
<p align="justify"><span style="font-family: Calibri, serif;">19.1 These Terms of Use shall be governed by and construed in accordance with English law.</span></p>
<p align="justify"><span style="font-family: Calibri, serif;">19.2 Any disputes relating to these Terms of Use shall be subject to the exclusive jurisdiction of the courts of England.</span></p>
<p align="justify">&nbsp;</p>
<p align="justify">&nbsp;</p>
<p align="justify">&nbsp;</p>'	
	render: ->
		dom.div
			className: "root"
			dom.div
				className: "row"
				dom.div
					className: "small-12 medium-9 medium-centered large-9 large-centered columns"
					dom.h2
						className: "bold"
						"SASENSEI TERMS OF USE"
					dom.p 
						dangerouslySetInnerHTML: __html: @props.terms.toString()


