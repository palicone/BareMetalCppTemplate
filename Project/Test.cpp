#include <Protomorph/Serialization/PJSONParser3.h>
#include <string_view>

void parseThisJSON(std::string_view svJSON, auto cb)
{
  ptmh::CJSON3StackAllocator j;
  j.LoadAndParse(svJSON, cb);
}


void Test()
{
  parseThisJSON("{ This : 2, AndThis : 3 }", [](ptmh::CJSON3StackAllocator::SJSON3Node* pRootNode)
    {
      return ptmh::CJSONParser3::EParseResult::OK;
    });
}
