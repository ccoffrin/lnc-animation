# For details of this cuts this file is demonstrating see http://arxiv.org/abs/1512.04644 

# assumes theta bounds are +/- around 0, w.o.l.g.
# this allows us to easily take the projection through reference angle of theta = 0

animation_steps = 60

#theta_ub = 0.261799 #15 degrees
theta_ub = 0.52 #30 degrees
vi_ub = 1.2
vi_lb = 0.8

vj_ub = 1.2
vj_lb = 0.8

vi_sigma = vi_ub+vi_lb
vj_sigma = vj_ub+vj_lb

wi_ub = vi_ub^2
wi_lb = vi_lb^2

wj_ub = vj_ub^2
wj_lb = vj_lb^2


vj_val = vj_lb
wj_val = vj_val^2


line_width = 3
receding_color = rgb(0.5,0.5,0.5)
lnc1_color = "darkorange1"
lnc2_color = "dodgerblue1"

file_name_prefix = "lnc"

vj_steps = seq(vj_lb, vj_ub, length.out=animation_steps)
#vj_steps = c((vj_lb+vj_ub)/2)
for (i in 1:length(vj_steps)) {

  vj_val = vj_steps[i]
  wj_val = vj_val^2

  pdf(paste("./pdfs/",file_name_prefix,"_",sprintf("%03d",i),".pdf",sep=""), pointsize=14, width=7, height=7, bg="white")
    x_lims = c(vi_lb*vj_lb*cos(theta_ub), vi_ub*vj_ub)
    y_lims = c(wi_lb, wi_ub)
    #print(x_lims)
    #print(y_lims)

    wi_steps = seq(wi_lb, wi_ub, length.out=30)

    plot(x_lims, y_lims, 
      main="Lifted Nonlinear Cuts for AC Power Flow", 
      sub=substitute(paste(w[i] %in% {}, "(", wil, ",", wiu,")  ", w[j] %in% {}, "(", wjl, ",", wju,")  ", theta %in% {}, "(", -tu, ",", tu, ")", sep=""), list(wil = wi_lb, wiu = wi_ub, wjl = wj_lb, wju = wj_ub, tu = theta_ub) ), 
      xlab=expression({w^r}[ij]), ylab=expression(w[i]), type="n")

    # cut through theta=0
    points(sqrt(wi_steps*wj_val), wi_steps, type="l", lwd=line_width)
    
    # cut through the extreme value of theta, theta_ub
    points(sqrt(wi_steps*wj_val)*cos(theta_ub), wi_steps, type="l", lty=1, lwd=line_width, col=receding_color)

    # UB connecting line
    points(c(sqrt(wi_ub*wj_val)*cos(theta_ub), sqrt(wi_ub*wj_val)), c(wi_ub, wi_ub), type="l", lty=1, lwd=line_width, col=receding_color)

    # LB connecting line
    points(c(sqrt(wi_lb*wj_val)*cos(theta_ub), sqrt(wi_lb*wj_val)), c(wi_lb, wi_lb), type="l", lty=1, lwd=line_width, col=receding_color)

    # lnc 1
    # vj_ub*cos(theta_ub)*vj_sigma*w_i == vi_sigma*vj_sigma*wr_ij - vi_ub*cos(theta_ub)*vi_sigma*w_j - vi_ub*vj_ub*cos(theta_ub)*(vi_lb*vj_lb - vi_ub*vj_ub) 
    lnc1_m = vi_sigma*vj_sigma/(vj_ub*cos(theta_ub)*vj_sigma)
    lnc1_b = (-vi_ub*vi_sigma*wj_val - vi_ub*vj_ub*(vi_lb*vj_lb - vi_ub*vj_ub))/(vj_ub*vj_sigma)
    abline(lnc1_b, lnc1_m, col=lnc1_color, lwd=line_width)
   
    # lnc 2
    # vj_lb*cos(theta_ub)*vj_sigma*w_i  == vi_sigma*vj_sigma*wr_ij - vi_lb*cos(theta_ub)*vi_sigma*w_j - vi_lb*vj_lb*cos(theta_ub)*(vi_ub*vj_ub - vi_lb*vj_lb)
    lnc2_m = vi_sigma*vj_sigma/(vj_lb*cos(theta_ub)*vj_sigma)
    lnc2_b = (-vi_lb*vi_sigma*wj_val - vi_lb*vj_lb*(vi_ub*vj_ub - vi_lb*vj_lb))/(vj_lb*vj_sigma)
    abline(lnc2_b, lnc2_m, col=lnc2_color, lwd=line_width)

    # documentation
    text( x_lims[1], y_lims[2]*0.97, pos=4, substitute(paste(w[j], " = ", wjv), list(wjv = sprintf("%.4f",wj_val))) ) #,     adj = c( 0, 1 ), col = "blue" )

    legend("bottomright", c("Surface", "Receding", "LNC 1", "LNC 2"), col = c("black", receding_color, lnc1_color, lnc2_color),
         lwd = c(line_width, line_width, line_width),
         merge = TRUE, bg="white")

  dev.off()
}