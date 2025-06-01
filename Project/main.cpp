#include <stdlib.h>
#include <vector>
#include <cstdint>
#include <stdio.h>
#include "TestDemoEndpointBase.h"

extern unsigned long _estack, _sidata, _sdata, _edata, _sbss, _ebss, RAM_USAGE;
typedef void (*pCtor)(void);
extern pCtor _sctors;
extern pCtor _ectors;
pCtor *pfTable;

extern "C"
{
  void* __dso_handle __attribute__ ((__weak__));
  void _fini(){}
}

typedef unsigned long DWORD;

int g_nCounter0 = 0;
int g_nCounter1 = 1;
int g_nCounter2 = 2;
int g_nCounter3 = 3;

void increaseCounters()
{
  g_nCounter0++;
  if (g_nCounter0 > 99)
  {
    g_nCounter0 = 0;
    g_nCounter1++;
    if (g_nCounter1 > 99)
    {
      g_nCounter2++;
      g_nCounter1 = 0;
      if (g_nCounter2 > 99)
      {
        g_nCounter3++;
        g_nCounter2 = 0;
      }
    }
  }
}

class CTest
{
public:
  CTest()
  {
    sm_nInstanceCounter++;
  }
  ~CTest()
  {
    sm_nInstanceCounter--;
  }
  static int Count() { return sm_nInstanceCounter; }
private:
  static int sm_nInstanceCounter;
};

int CTest::sm_nInstanceCounter = 0;

CTest g_Test;

unsigned int Fibonacci(unsigned int n)
{
  unsigned int nF0 = 0;
  unsigned int nFib = 1;
  unsigned int i = 0;
  for ( i = 0; i <= n; ++i )
  {
    nF0 += nFib;
    nFib = nF0 - nFib;
  }
  return nFib;
}

int g_nCnt;

float floatTezt()
{
  DWORD *pdwCPACR = (DWORD *)0xE000ED88;
  DWORD dwCPACR = *pdwCPACR;
  dwCPACR |= 0x00F00000;
  *pdwCPACR = dwCPACR;
  float fA = 1.1;
  float fB = 2.2;
  float fC = 3.3;

  fC = fA + fB;
  return fC;
}

std::vector<unsigned int> Fibonaccis(size_t nCount)
{
  std::vector<unsigned int> result;
  for ( size_t n = 0; n < nCount; ++n )
  {
    result.emplace_back(Fibonacci(n));
  }
  return result;
}

void Test();

class CTestDemoEndpointImpl : public CTestDemoEndpointBase
{

}g_PARCNode;

int main(int argc, char** argv)
{
  //testing::InitGoogleTest(&argc, argv);
  floatTezt();  
  CTest test;
  CTest *pTest = new CTest();
  volatile unsigned int
  nFib = Fibonacci(0);
  nFib = Fibonacci(1);
  nFib = Fibonacci(2);
  nFib = Fibonacci(3);
  nFib = Fibonacci(4);
  nFib = Fibonacci(5);
  nFib = Fibonacci(6);
  nFib = Fibonacci(7);

  std::vector<unsigned int> vFibs = Fibonaccis(10);
  std::vector<unsigned int> vFibs0 = Fibonaccis(10);
  std::vector<unsigned int> vFibs1 = Fibonaccis(10);
  std::vector<unsigned int> vFibs2 = Fibonaccis(50);
  vFibs2.clear();
  std::vector<unsigned int> vFibs3 = Fibonaccis(10);
  std::vector<unsigned int> vFibs4 = Fibonaccis(10);
  std::vector<unsigned int> vFibs5 = Fibonaccis(10);
  std::vector<unsigned int> vFibs6 = Fibonaccis(10);
  
  if ( nFib != vFibs[7])
  {
    asm(" NOP");
  }
  nFib = vFibs[6];

  delete pTest;
  
  //int iRet = RUN_ALL_TESTS();  
  
  while ( 1 )
  {
    Test();
    increaseCounters();
    void *pData = malloc(4);
    g_nCnt++;
    if ( g_nCnt & 1 )
    {
      nFib = Fibonacci(CTest::Count());
      asm(" NOP");     
      //asm(" VADD S1,S2,S3");     
    }
    nFib = Fibonacci(9);
    free(pData);
    asm(" NOP");

    g_PARCNode.Dispatch("", "", nullptr);
  }
}

#include <sys/types.h>

extern void (*__preinit_array_start []) (void);
extern void (*__preinit_array_end []) (void);
extern void (*__init_array_start []) (void);
extern void (*__init_array_end []) (void);

extern "C" {
extern void _init (void);

#define ARMv7M_VTOR_ADDRESS 0xE000ED08
typedef void (*pfnVector)();
extern const pfnVector g_pfnVectors[];
typedef void (*pfn)();

static const unsigned long s_InvalidInst = 0xFFFFFFFF;
static pfn s_pfnInvlaid= (pfn)&s_InvalidInst;

void invalid()
{
  s_pfnInvlaid();  
}

__attribute__( ( naked ) )
void ResetHandler()
{
  [[maybe_unused]] register unsigned long *pulSP __asm("sp") = &_estack;
  unsigned long *pulSrc = &_sidata;
  unsigned long *pulDest = &_sdata;
  const pfnVector ** pVTOR = (const pfnVector **)ARMv7M_VTOR_ADDRESS;
  *pVTOR = g_pfnVectors;
 
  while( pulDest < &_edata )
  {
    *pulDest++ = *pulSrc++;
  }
  
  pulDest = &_sbss;
  while ( pulDest < &_ebss )
  {
    *pulDest++ = 0;
  }
  
  size_t count;
  size_t i;

  count = __preinit_array_end - __preinit_array_start;
  for (i = 0; i < count; i++)
    __preinit_array_start[i] ();

  //_init ();

  count = __init_array_end - __init_array_start;
  for (i = 0; i < count; i++)
    __init_array_start[i] ();  

  //invalid();

  main(0, nullptr);

  asm(" BKPT #0");
  while( 1 );    
}
}

struct SARMv7MExceptionContext
{
  unsigned long m_dwExR0;
  unsigned long m_dwExR1;
  unsigned long m_dwExR2;
  unsigned long m_dwExR3;
  unsigned long m_dwExR12;
  unsigned long m_dwExLR;
  unsigned long m_dwExPC;
  unsigned long m_dwExPSR;
};

#define ARMv7M_EX_CTX_TO_R0() [[maybe_unused]] register SARMv7MExceptionContext * pARMv7MExceptionContext __asm("r0"); \
  register unsigned long dwLR __asm("lr"); \
  if ( dwLR & 4 )                          \
    asm(" mrs r0, psp");                   \
  else                                     \
    asm(" mrs r0, msp");                   


__attribute__( ( naked ) )
void NMIHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void HardFaultHandler()
{
  ARMv7M_EX_CTX_TO_R0();
  asm(" BKPT #0");
  while( 1 );    
  
  asm(" MOV R0,SP");
  asm(" LDR R1,[R0,#20]");
  asm(" BIC R1,R1,#1");
  asm(" STR R1,[R0,#24]");

//  asm(" LDR R1,=0xDEADBEEF");
//  asm(" STR R1,[R0,#24]");


  asm(" LDR R1,=0x01000000");
  asm(" STR R1,[R0,#28]");
  
  asm(" LDR R0,=0xE000ED28"); //CFSR
  asm(" LDR R1,[R0,#0]");
  asm(" STR R1,[R0,#0]");
  
   
  asm(" LDR R0,=0xE000ED2C"); //HFSR
  asm(" LDR R1,[R0,#0]");
  asm(" STR R1,[R0,#0]");
  
  asm(" BX LR");
}

__attribute__( ( naked ) )
void MemManageHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void BusFaultHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void UsageFaultHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void SVCCallHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void DebugMonitorHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void PendSVHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

__attribute__( ( naked ) )
void SysTickHandler()
{
  asm(" BKPT #0");
  while( 1 );    
}

#define RESERVED_HANDLER nullptr
__attribute__ ((section(".isr_vector")))
const pfnVector g_pfnVectors[] =
{
  (pfnVector)&_estack,
  ResetHandler,
  NMIHandler,
  HardFaultHandler,
  MemManageHandler,
  BusFaultHandler,
  UsageFaultHandler,
  RESERVED_HANDLER,
  RESERVED_HANDLER,
  RESERVED_HANDLER,
  RESERVED_HANDLER,
  SVCCallHandler,
  DebugMonitorHandler,
  RESERVED_HANDLER,
  PendSVHandler,
  SysTickHandler
};

#include <unistd.h>
void *g_pProgramBreak = &_ebss;
extern "C" {
void *_sbrk(intptr_t increment)
{
  void *pCurrentProgramBreak = g_pProgramBreak;
  void *pNewProgramBreak = (char *)pCurrentProgramBreak + increment;
  register unsigned long ulSP __asm("sp");
  if ( ((unsigned long)(pNewProgramBreak)) > ulSP )
  {
    asm(" BKPT #0");
    return nullptr;
  }
  g_pProgramBreak = pNewProgramBreak;
  return pCurrentProgramBreak;
}

void abort()
{
  asm(" BKPT #0");
  while(1);
}

// newer GCC misses these... somewhere in newlib apparently
//void _close(void)
//{
//}
//void _lseek(void)
//{
//
//}
//void _read(void)
//{
//}
//void _write(void)
//{
//}
}