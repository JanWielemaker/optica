/*  $Id: qp.c,v 1.1.1.1 1999/11/17 16:33:38 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

#define HAVE_GETTIMEOFDAY 1
#include <sys/time.h>
#include <stdio.h>

double
get_time()
{ 
#ifndef HAVE_GETTIMEOFDAY
  return (double)time((time_t *)NULL);
#else
  struct timeval tp;

  gettimeofday(&tp, NULL);
  return (double)tp.tv_sec + (double)tp.tv_usec/1000000.0;
#endif
}
  
