{smcl}
{* *! version 1.2.0  28dec2012}{...}
{vieweralsosee "[R] clogit" "help clogit"}{...}
{vieweralsosee "[R] mixlogit" "help mixlogit"}{...}
{vieweralsosee "lslogit on GitHub" "browse https://github.com/mloeffler/lslogit/"}{...}
{viewerjumpto "Syntax" "lslogit##syntax"}{...}
{viewerjumpto "Description" "lslogit##description"}{...}
{viewerjumpto "Options" "lslogit##options"}{...}
{viewerjumpto "References" "lslogit##references"}{...}
{viewerjumpto "Author" "lslogit##author"}{...}
{title:Title}

{phang}
{bf:lslogit} {hline 2} Mixed logit labor supply model


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:lslogit}
    {depvar}
    {ifin}
    {weight}
    {cmd:,}
    {cmdab:gr:oup:(}{varname}{cmd:)}
    {cmdab:c:onsumption:(}{varname}{cmd:)}
    {cmdab:l:eisure:(}{varlist}{cmd:)}
    [{it:options}]

{p 8 17 2}
{cmdab:lslpred}
    {it:newvarlist}
    {ifin}
    [{cmd:,} {cmd:xb} {cmd:pc1}]


{synoptset 21 tabbed}{...}
{synopthdr:lslogit options}
{synoptline}
{syntab:Model}
{p2coldent:* {opth gr:oup(varname)}}matched group variable{p_end}
{synopt:{opt quad:ratic}}quadratic utility function{p_end}
{synopt:{opt tran:slog}}translog utility function{p_end}
{synopt:{opt boxc:ox}}Box-Cox utility function{p_end}
{synopt:{opt boxcc(#)}}normalize consumption for Box-Cox transformation{p_end}
{synopt:{opt boxcl(#)}}normalize leisure for Box-Cox transformation{p_end}
{synopt:{opt dr:aws(#)}}number of Halton draws used to approximate{p_end}
{synopt:{opt burn(#)}}number of initial Halton draws to burn{p_end}
{synopt:{opt [no]round}}enable/disable rounding of hourly and monthly wages{p_end}

{syntab:Right hand side}
{p2coldent:* {opth c:onsumption(varname)}}consumption variable{p_end}
{p2coldent:* {opth l:eisure(varlist)}}leisure variable(s){p_end}
{synopt:{opth cx(varlist)}}interactions with consumption{p_end}
{synopt:{opth lx1(varlist)}}interactions with leisure (person 1){p_end}
{synopt:{opth lx2(varlist)}}interactions with leisure (person 2){p_end}
{synopt:{opth c2x(varlist)}}interactions with consumption squared{p_end}
{synopt:{opth l2x1(varlist)}}interactions with leisure squared (person 1){p_end}
{synopt:{opth l2x2(varlist)}}interactions with leisure squared (person 2){p_end}
{synopt:{opth ind:eps(varlist)}}taste shifters{p_end}

{syntab:Random preferences}
{synopt:{opt rand:vars(coeflist)}}indices of random coefficients{p_end}
{synopt:{opt corr}}correlation between random coefficients{p_end}

{syntab:Wage estimation}
{synopt:{opth hw:age(varlist)}}hourly wage rate(s){p_end}
{synopt:{opth heckm:an(varlist)}}wage equation{p_end}
{synopt:{opth select(varlist)}}selection equation{p_end}

{syntab:Wage prediction}
{synopt:{opth wagep:red(varlist)}}integrate out wage prediction error(s){p_end}
{synopt:{opth day:s(varname)}}days per year{p_end}
{synopt:{opt totalt:ime(#)}}time endowment per week{p_end}
{synopt:{opt hecksig:ma(sigma)}}standard error(s) of the wage regression(s){p_end}
{synopt:{opt taxr:eg(name)}}estimates of the tax regrssion{p_end}
{synopt:{opth tria1(varlist)}}interactions with earnings (person 1){p_end}
{synopt:{opth tria2(varlist)}}interactions with earnings (person 2){p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt group(varname)}, {opt consumption(varname)} and {opt leisure(varlist)} are required.{p_end}

{p 4 6 2}
{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are allowed (see {help weight}),
but they are interpreted to apply to the group, not to individual observations. See
{mansection R clogitRemarksUseofweights:{it:Use of weights}} in {bf:[R] clogit}.{p_end}


{synoptset 21 tabbed}{...}
{synopthdr:lslpred options}
{synoptline}
{synopt:{opt xb}}predict systematic utility{p_end}
{synopt:{opt pc1}}predict choice probabilities{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:lslogit} fits mixed logit models with particular focus on the estimation
of structural labor supply models in the discrete choice context. It allows for
several different functional forms, very flexible utility specifications,
both observed and unobserved heterogeneity in preferences and can be easily
augmented with flexible dummy refinement. Moreover, it allows to integrate out
the wage prediction error during the estimation.

{pstd}
Technically, it is an extension to the Stata command {help clogit} and the
user-written routine {help mixlogit} ({help lslogit##hole_2007:Hole, 2007}). {cmd:lslogit}
makes use of maximum simulated likelihood methods
({help lslogit##train_2009:Train, 2009}).

{pstd}
{cmd:lslpred} predicts the systematic utility and/or the choice probabilities
according to the estimated coefficients.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opth group(varname)} specifies an identifier variable for the matched groups.

{phang}
{opt quadratic} specifies the functional form of the systematic utility to be
quadratic ({help lslogit##keane_moffitt_1998:Keane and Moffitt, 1998}). If no
functional form is specified, {cmd:lslogit} will assume a quadratic utility
function.

{phang}
{opt translog} specifies a translog utility function ({help lslogit##vansoest_1995:van Soest, 1995}).

{phang}
{opt boxcox} specifies a Box-Cox transformed utility function
({help lslogit##aaberge_etal_1995:Aaberge et al., 1995}). The likelihood
function converges more easily when consumption and leisure variables
have a small range. Therefore, consumption is divided by {opt boxcc(#)} and
leisure is divided by {opt boxcl(#)} (default is {bf:boxcl(1000)} and
{bf:boxcl(80)}).

{phang}
{opt draws(#)} is the number of Halton draws that are used to approximate
the likelihood contribution of each group (default is {bf:draws(50)}).

{phang}
{opt burn(#)} denotes the number of highly correlated initial Halton draws
to be burned (default is {bf:burn(15)}).

{phang}
{opt [no]round} enables/disables rounding of hourly and monthly wages. Rounding
may cause problems when estimating wages and working hours jointly because of 
non-concave parts in the likelihood function.


{marker references}{...}
{title:References}

{marker aaberge_etal_1995}{...}
{phang}
Aaberge, R., Dagsvik, J. K. and Str�m, S. (1995). Labor supply responses and welfare effects of tax reforms,
{it:The Scandinavian Journal of Economics} 97(4): 635-659.

{marker hole_2007}{...}
{phang}
Hole, A. R. (2007). Fitting mixed logit models by using maximum simulated likelihood,
{it:Stata Journal} 7(3), 388-401.

{marker keane_moffitt_1998}{...}
{phang}
Keane, M. P. and Moffitt, R. (1998). A structural model of multiple welfare program participation and labor supply,
{it:International Economic Review} 39(3): 553-589.

{marker train_2009}{...}
{phang}
Train, K. E. (2009). {it:Discrete Choice Methods with Simulation}. 2nd ed. Cambridge University Press.

{marker vansoest_1995}{...}
{phang}
van Soest, A. (1995). Structural models of family labor supply -- a discrete choice approach,
{it:The Journal of Human Resources} 30(1): 63-88.
{p_end}


{marker author}{...}
{title:Author}

{phang}
{cmd:lslogit} was written by Max L�ffler ({browse "mailto:loeffler@iza.org":loeffler@iza.org}), Institute for the
Study of Labor (IZA), Bonn, Germany.
    

