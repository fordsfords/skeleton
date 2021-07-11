/* skeleton.c */
/*
# This code and its documentation is Copyright 2002-2021 Steven Ford
# and licensed "public domain" style under Creative Commons "CC0":
#   http://creativecommons.org/publicdomain/zero/1.0/
# To the extent possible under law, the contributors to this project have
# waived all copyright and related or neighboring rights to this work.
# In other words, you can use this code for any purpose without any
# restrictions.  This work is published from: United States.  The project home
# is https://github.com/fordsfords/skeleton
*/

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#ifdef _WIN32
  #include <winsock2.h>
  #define SLEEP(s) Sleep((s)*1000)
  /* Is there a proper Win equiv to abort()? */
  #define ABORT() do { *((char *)(0)) = 0xff; }
#else
  #include <stdlib.h>
  #include <unistd.h>
  #define SLEEP(s) sleep(s)
  #define ABORT() abort()
#endif


#ifdef _WIN32
  /* PERR is non-portable to Windows and needs a proper equiv. */
  #define PERR(s_) do { \
    char b_[256]; \
    fprintf(stderr, "ERROR (%s line %d): %s errno=%u\n", \
      __FILE__, __LINE__, s_, errno); \
    fflush(stderr); \
    ABORT(); \
  } while (0)
#else
  #define PERR(s_) do { \
    fprintf(stderr, "ERROR (%s line %d): %s errno=%u ('%s')\n", \
      __FILE__, __LINE__, s_, errno, strerror(errno)); \
    fflush(stderr); \
    ABORT(); \
  } while (0)
#endif

#define ERR(s_) do { \
  fprintf(stderr, "ERROR (%s line %d): %s\n", \
    __FILE__, __LINE__, s_); \
  fflush(stderr); \
  ABORT(); \
} while (0)

#define ASSRT(cond_) do { \
  if (! (cond_)) { \
    fprintf(stderr, "\n%s:%d, ERROR: '%s' not true\n", \
      __FILE__, __LINE__, #cond_); \
    abort(); \
  } \
} while (0)


/* Options and their defaults */
char *o_conf_file = NULL;


char usage_str[] = "Usage: skeleton [-h] [-c conf_file]";

void usage(char *msg) {
  if (msg) fprintf(stderr, "%s\n", msg);
  fprintf(stderr, "%s\n", usage_str);
  exit(1);
}

void help() {
  fprintf(stderr, "%s\n", usage_str);
  fprintf(stderr, "where:\n"
                  "  -h           : print help\n"
                  "  -c conf_file : config file\n");
  exit(0);
}


int main(int argc, char **argv)
{
  int opt;

#ifdef _WIN32
  /* windows-specific code */
  WSADATA wsadata;
  int wsStat = WSAStartup(MAKEWORD(2,2), &wsadata);
  if (wsStat != 0) {printf("line %d: wsStat=%d\n",__LINE__,wsStat);exit(1);}
#endif

  while ((opt = getopt(argc, argv, "hc:")) != EOF) {
    switch (opt) {
      case 'c':
        o_conf_file = strdup(optarg);
        break;
      case 'h':
        help();
        break;
      default:
        usage(NULL);
    }  /* switch opt */
  }  /* while getopt */

  if (optind != argc) { usage("Extra parameter(s)"); }

  if (o_conf_file) {
    printf("Config file=%s\n", o_conf_file);
  }

#ifdef _WIN32
  WSACleanup();
#endif
}  /* main */
