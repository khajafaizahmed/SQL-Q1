<?xml version="1.0" encoding="utf-16"?>
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.564" Build="16.0.1000.6" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtUseDb StatementCompId="1" StatementId="1" StatementText="/*****************************************************************************&#xA; STEP 1: CREATE DATABASE (IF NEEDED), CREATE TABLE T WITH NO INDEXES, NO PK&#xA;******************************************************************************/&#xA;&#xA;USE QuizOne;&#xA;" StatementType="USE DATABASE" RetrievedFromCache="false" Database="[QuizOne]" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtCond StatementCompId="1" StatementId="1" StatementText="&#xA;IF OBJECT_ID('dbo.T', 'U') IS NOT NULL" StatementType="COND" RetrievedFromCache="false">
          <Condition />
          <Then>
            <Statements>
              <StmtSimple StatementCompId="2" StatementId="2" StatementText="&#xA;    DROP TABLE dbo.T" StatementType="DROP OBJECT" RetrievedFromCache="false" />
            </Statements>
          </Then>
        </StmtCond>
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;-- col1 is NOT NULL to allow a PK later&#xA;CREATE TABLE dbo.T&#xA;(&#xA;    col1 INT NOT NULL,&#xA;    col2 VARCHAR(50),&#xA;    col3 DATETIME&#xA;)" StatementType="CREATE TABLE" RetrievedFromCache="false" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;/*****************************************************************************&#xA; STEP 2: INSERT ROWS (HEAP) AND SELECT * (TABLE SCAN)&#xA;******************************************************************************/&#xA;PRINT '*** STEP 2: Inserting rows into table T (Heap, no PK) ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="2" StatementId="2" StatementText="DECLARE @i INT = 1;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="3" StatementId="3" StatementText="DECLARE @n INT = 1000;  -- Change this for 50000, 100000, etc.&#xA;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="4" StatementId="4" StatementText="TRUNCATE TABLE dbo.T" StatementType="TRUNCATE TABLE" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtCond StatementCompId="5" StatementId="5" StatementText=";&#xA;&#xA;WHILE @i &lt;= @n" StatementType="COND" RetrievedFromCache="false">
          <Condition />
          <Then>
            <Statements>
              <StmtSimple StatementCompId="6" StatementEstRows="1" StatementId="6" StatementOptmLevel="TRIVIAL" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.0200032" StatementText="&#xA;BEGIN&#xA;    INSERT INTO dbo.T (col1, col2, col3)&#xA;    VALUES (@i, CONCAT('Row number ', @i), GETDATE())" StatementType="INSERT" QueryHash="0xB135123737A92B4D" QueryPlanHash="0x3D0269B931E48BAF" RetrievedFromCache="false" SecurityPolicyApplied="false">
                <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
                <QueryPlan CachedPlanSize="16" CompileTime="0" CompileCPU="0" CompileMemory="200">
                  <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
                  <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
                  <RelOp AvgRowSize="9" EstimateCPU="2E-06" EstimateIO="0.02" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Insert" NodeId="0" Parallel="false" PhysicalOp="Clustered Index Insert" EstimatedTotalSubtreeCost="0.0200032">
                    <OutputList />
                    <ScalarInsert DMLRequestSort="false">
                      <DefinedValues>
                        <DefinedValue>
                          <ColumnReference Column="Expr1002" />
                          <ScalarOperator ScalarString="CONVERT_IMPLICIT(varchar(50),concat('Row number ',CONVERT_IMPLICIT(varchar(12),[@i],0)),0)">
                            <Convert DataType="varchar" Length="50" Style="0" Implicit="true">
                              <ScalarOperator>
                                <Intrinsic FunctionName="concat">
                                  <ScalarOperator>
                                    <Const ConstValue="'Row number '" />
                                  </ScalarOperator>
                                  <ScalarOperator>
                                    <Convert DataType="varchar" Length="12" Style="0" Implicit="true">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Column="@i" />
                                        </Identifier>
                                      </ScalarOperator>
                                    </Convert>
                                  </ScalarOperator>
                                </Intrinsic>
                              </ScalarOperator>
                            </Convert>
                          </ScalarOperator>
                        </DefinedValue>
                        <DefinedValue>
                          <ColumnReference Column="Expr1003" />
                          <ScalarOperator ScalarString="getdate()">
                            <Identifier>
                              <ColumnReference Column="ConstExpr1004">
                                <ScalarOperator>
                                  <Intrinsic FunctionName="getdate" />
                                </ScalarOperator>
                              </ColumnReference>
                            </Identifier>
                          </ScalarOperator>
                        </DefinedValue>
                      </DefinedValues>
                      <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[PK_T]" IndexKind="Clustered" Storage="RowStore" />
                      <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[IX_T_col1]" IndexKind="NonClustered" Storage="RowStore" />
                      <SetPredicate>
                        <ScalarOperator ScalarString="[QuizOne].[dbo].[T].[col1] = RaiseIfNullInsert([@i]),[QuizOne].[dbo].[T].[col2] = [Expr1002],[QuizOne].[dbo].[T].[col3] = [Expr1003]">
                          <ScalarExpressionList>
                            <ScalarOperator>
                              <MultipleAssign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                                  <ScalarOperator>
                                    <Intrinsic FunctionName="RaiseIfNullInsert">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Column="@i" />
                                        </Identifier>
                                      </ScalarOperator>
                                    </Intrinsic>
                                  </ScalarOperator>
                                </Assign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                                  <ScalarOperator>
                                    <Identifier>
                                      <ColumnReference Column="Expr1002" />
                                    </Identifier>
                                  </ScalarOperator>
                                </Assign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
                                  <ScalarOperator>
                                    <Identifier>
                                      <ColumnReference Column="Expr1003" />
                                    </Identifier>
                                  </ScalarOperator>
                                </Assign>
                              </MultipleAssign>
                            </ScalarOperator>
                          </ScalarExpressionList>
                        </ScalarOperator>
                      </SetPredicate>
                    </ScalarInsert>
                  </RelOp>
                </QueryPlan>
              </StmtSimple>
              <StmtSimple StatementCompId="7" StatementId="7" StatementText=";&#xA;    SET @i += 1;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
            </Statements>
          </Then>
        </StmtCond>
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="10" StatementId="8" StatementText="END;&#xA;&#xA;PRINT '*** STEP 2: SELECT * (Expect Table Scan) ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="11" StatementId="9" StatementText="SET STATISTICS IO ON;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="12" StatementId="10" StatementText="SET STATISTICS TIME ON;&#xA;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="13" StatementEstRows="1000" StatementId="11" StatementOptmLevel="TRIVIAL" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.00734496" StatementText="SELECT * FROM dbo.T" StatementType="SELECT" QueryHash="0x9DD6F80EE91AB69F" QueryPlanHash="0xD2E62ECB0D146488" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan CachedPlanSize="16" CompileTime="0" CompileCPU="0" CompileMemory="160">
            <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
            <RelOp AvgRowSize="48" EstimateCPU="0.001257" EstimateIO="0.00608796" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1000" EstimatedRowsRead="1000" LogicalOp="Clustered Index Scan" NodeId="0" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.00734496" TableCardinality="1000">
              <OutputList>
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
              </OutputList>
              <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                  </DefinedValue>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                  </DefinedValue>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
                  </DefinedValue>
                </DefinedValues>
                <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[PK_T]" IndexKind="Clustered" Storage="RowStore" />
              </IndexScan>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="14" StatementId="12" StatementText=";  -- Table Scan expected&#xA;&#xA;SET STATISTICS TIME OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="15" StatementId="13" StatementText="SET STATISTICS IO OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;/*****************************************************************************&#xA; STEP 3: CREATE A CLUSTERED INDEX (PRIMARY KEY), RE-INSERT ROWS, AND SELECT *&#xA;        (CLUSTERED INDEX SCAN)&#xA;******************************************************************************/&#xA;PRINT '*** STEP 3: Creating Clustered Index (Primary Key) ***';&#xA;&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtCond StatementCompId="2" StatementEstRows="1" StatementId="2" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="GoodEnoughPlanFound" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.00986596" StatementText="IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'PK_T')" StatementType="COND WITH QUERY" QueryHash="0xB3BFFAC105E40B87" QueryPlanHash="0xBE5082EE335C1A78" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <Condition>
            <QueryPlan NonParallelPlanReason="NonParallelizableIntrinsicFunction" CachedPlanSize="40" CompileTime="4" CompileCPU="4" CompileMemory="960">
              <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
              <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
              <OptimizerStatsUsage>
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[nc]" ModificationCount="373" SamplingPercent="100" LastUpdate="2009-04-13T12:59:17.37" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[_WA_Sys_00000004_00000036]" ModificationCount="36" SamplingPercent="100" LastUpdate="2025-04-15T22:27:11.91" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Statistics="[clst]" ModificationCount="11" SamplingPercent="100" LastUpdate="2025-04-15T19:05:04.19" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[clst]" ModificationCount="373" SamplingPercent="100" LastUpdate="2009-04-13T12:59:17.36" />
              </OptimizerStatsUsage>
              <RelOp AvgRowSize="11" EstimateCPU="1E-07" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Compute Scalar" NodeId="0" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.00986596">
                <OutputList>
                  <ColumnReference Column="Expr1023" />
                </OutputList>
                <ComputeScalar>
                  <DefinedValues>
                    <DefinedValue>
                      <ColumnReference Column="Expr1023" />
                      <ScalarOperator ScalarString="CASE WHEN [Expr1024] THEN (1) ELSE (0) END">
                        <IF>
                          <Condition>
                            <ScalarOperator>
                              <Identifier>
                                <ColumnReference Column="Expr1024" />
                              </Identifier>
                            </ScalarOperator>
                          </Condition>
                          <Then>
                            <ScalarOperator>
                              <Const ConstValue="(1)" />
                            </ScalarOperator>
                          </Then>
                          <Else>
                            <ScalarOperator>
                              <Const ConstValue="(0)" />
                            </ScalarOperator>
                          </Else>
                        </IF>
                      </ScalarOperator>
                    </DefinedValue>
                  </DefinedValues>
                  <RelOp AvgRowSize="9" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Left Semi Join" NodeId="1" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00986586">
                    <OutputList>
                      <ColumnReference Column="Expr1024" />
                    </OutputList>
                    <NestedLoops Optimized="false">
                      <DefinedValues>
                        <DefinedValue>
                          <ColumnReference Column="Expr1024" />
                        </DefinedValue>
                      </DefinedValues>
                      <ProbeColumn>
                        <ColumnReference Column="Expr1024" />
                      </ProbeColumn>
                      <RelOp AvgRowSize="9" EstimateCPU="1.157E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Constant Scan" NodeId="2" Parallel="false" PhysicalOp="Constant Scan" EstimatedTotalSubtreeCost="1.157E-06">
                        <OutputList />
                        <ConstantScan />
                      </RelOp>
                      <RelOp AvgRowSize="9" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimateRowsWithoutRowGoal="1.00109" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00986052">
                        <OutputList />
                        <NestedLoops Optimized="false">
                          <OuterReferences>
                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                          </OuterReferences>
                          <RelOp AvgRowSize="15" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Inner Join" NodeId="5" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00657126">
                            <OutputList>
                              <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                            </OutputList>
                            <NestedLoops Optimized="false">
                              <OuterReferences>
                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                              </OuterReferences>
                              <RelOp AvgRowSize="15" EstimateCPU="8.8E-07" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Filter" NodeId="6" Parallel="false" PhysicalOp="Filter" EstimatedTotalSubtreeCost="0.00328398">
                                <OutputList>
                                  <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                  <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                </OutputList>
                                <Filter StartupExpression="false">
                                  <RelOp AvgRowSize="15" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Index Seek" NodeId="7" Parallel="false" PhysicalOp="Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="230">
                                    <OutputList>
                                      <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                      <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                    </OutputList>
                                    <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                      <DefinedValues>
                                        <DefinedValue>
                                          <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                        </DefinedValue>
                                        <DefinedValue>
                                          <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                        </DefinedValue>
                                      </DefinedValues>
                                      <Object Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Index="[nc]" Alias="[i]" IndexKind="NonClustered" Storage="RowStore" />
                                      <SeekPredicates>
                                        <SeekPredicateNew>
                                          <SeekKeys>
                                            <Prefix ScanType="EQ">
                                              <RangeColumns>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="name" />
                                              </RangeColumns>
                                              <RangeExpressions>
                                                <ScalarOperator ScalarString="N'PK_T'">
                                                  <Const ConstValue="N'PK_T'" />
                                                </ScalarOperator>
                                              </RangeExpressions>
                                            </Prefix>
                                          </SeekKeys>
                                        </SeekPredicateNew>
                                      </SeekPredicates>
                                    </IndexScan>
                                  </RelOp>
                                  <Predicate>
                                    <ScalarOperator ScalarString="has_access('CO',[QuizOne].[sys].[sysidxstats].[id] as [i].[id])=(1)">
                                      <Compare CompareOp="EQ">
                                        <ScalarOperator>
                                          <Intrinsic FunctionName="has_access">
                                            <ScalarOperator>
                                              <Const ConstValue="'CO'" />
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                              </Identifier>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="" />
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="" />
                                            </ScalarOperator>
                                          </Intrinsic>
                                        </ScalarOperator>
                                        <ScalarOperator>
                                          <Const ConstValue="(1)" />
                                        </ScalarOperator>
                                      </Compare>
                                    </ScalarOperator>
                                  </Predicate>
                                </Filter>
                              </RelOp>
                              <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Clustered Index Seek" NodeId="9" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="230">
                                <OutputList />
                                <IndexScan Lookup="true" Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                  <DefinedValues />
                                  <Object Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Index="[clst]" Alias="[i]" TableReferenceId="-1" IndexKind="Clustered" Storage="RowStore" />
                                  <SeekPredicates>
                                    <SeekPredicateNew>
                                      <SeekKeys>
                                        <Prefix ScanType="EQ">
                                          <RangeColumns>
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                          </RangeColumns>
                                          <RangeExpressions>
                                            <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[id] as [i].[id]">
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                              </Identifier>
                                            </ScalarOperator>
                                            <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[indid] as [i].[indid]">
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                              </Identifier>
                                            </ScalarOperator>
                                          </RangeExpressions>
                                        </Prefix>
                                      </SeekKeys>
                                    </SeekPredicateNew>
                                  </SeekPredicates>
                                  <Predicate>
                                    <ScalarOperator ScalarString="([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(67108864))=(0) AND (([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(1))&lt;(0) OR ([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(1))&gt;(0))">
                                      <Logical Operation="AND">
                                        <ScalarOperator>
                                          <Compare CompareOp="EQ">
                                            <ScalarOperator>
                                              <Arithmetic Operation="BIT_AND">
                                                <ScalarOperator>
                                                  <Identifier>
                                                    <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                  </Identifier>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(67108864)" />
                                                </ScalarOperator>
                                              </Arithmetic>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="(0)" />
                                            </ScalarOperator>
                                          </Compare>
                                        </ScalarOperator>
                                        <ScalarOperator>
                                          <Logical Operation="OR">
                                            <ScalarOperator>
                                              <Compare CompareOp="LT">
                                                <ScalarOperator>
                                                  <Arithmetic Operation="BIT_AND">
                                                    <ScalarOperator>
                                                      <Identifier>
                                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                      </Identifier>
                                                    </ScalarOperator>
                                                    <ScalarOperator>
                                                      <Const ConstValue="(1)" />
                                                    </ScalarOperator>
                                                  </Arithmetic>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(0)" />
                                                </ScalarOperator>
                                              </Compare>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Compare CompareOp="GT">
                                                <ScalarOperator>
                                                  <Arithmetic Operation="BIT_AND">
                                                    <ScalarOperator>
                                                      <Identifier>
                                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                      </Identifier>
                                                    </ScalarOperator>
                                                    <ScalarOperator>
                                                      <Const ConstValue="(1)" />
                                                    </ScalarOperator>
                                                  </Arithmetic>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(0)" />
                                                </ScalarOperator>
                                              </Compare>
                                            </ScalarOperator>
                                          </Logical>
                                        </ScalarOperator>
                                      </Logical>
                                    </ScalarOperator>
                                  </Predicate>
                                </IndexScan>
                              </RelOp>
                            </NestedLoops>
                          </RelOp>
                          <RelOp AvgRowSize="9" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="10" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="2763">
                            <OutputList />
                            <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                              <DefinedValues />
                              <Object Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Index="[clst]" Alias="[obj]" IndexKind="Clustered" Storage="RowStore" />
                              <SeekPredicates>
                                <SeekPredicateNew>
                                  <SeekKeys>
                                    <Prefix ScanType="EQ">
                                      <RangeColumns>
                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Alias="[obj]" Column="id" />
                                      </RangeColumns>
                                      <RangeExpressions>
                                        <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[id] as [i].[id]">
                                          <Identifier>
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                          </Identifier>
                                        </ScalarOperator>
                                      </RangeExpressions>
                                    </Prefix>
                                  </SeekKeys>
                                </SeekPredicateNew>
                              </SeekPredicates>
                            </IndexScan>
                          </RelOp>
                        </NestedLoops>
                      </RelOp>
                    </NestedLoops>
                  </RelOp>
                </ComputeScalar>
              </RelOp>
            </QueryPlan>
          </Condition>
          <Then>
            <Statements>
              <StmtSimple StatementCompId="3" StatementId="3" StatementText="&#xA;BEGIN&#xA;    ALTER TABLE dbo.T DROP CONSTRAINT PK_T" StatementType="ALTER TABLE" RetrievedFromCache="false" />
            </Statements>
          </Then>
        </StmtCond>
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;PRINT '*** Re-inserting rows for Clustered Index Scan ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="2" StatementId="2" StatementText="DECLARE @i2 INT = 1;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="3" StatementId="3" StatementText="DECLARE @n2 INT = 1000;  -- Change this as well if you want to test a different row count&#xA;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="4" StatementId="4" StatementText="TRUNCATE TABLE dbo.T" StatementType="TRUNCATE TABLE" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtCond StatementCompId="5" StatementId="5" StatementText=";&#xA;&#xA;WHILE @i2 &lt;= @n2" StatementType="COND" RetrievedFromCache="false">
          <Condition />
          <Then>
            <Statements>
              <StmtSimple StatementCompId="6" StatementEstRows="1" StatementId="6" StatementOptmLevel="TRIVIAL" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.0200032" StatementText="&#xA;BEGIN&#xA;    INSERT INTO dbo.T (col1, col2, col3)&#xA;    VALUES (@i2, CONCAT('Row number ', @i2), GETDATE())" StatementType="INSERT" QueryHash="0xB135123737A92B4D" QueryPlanHash="0x3D0269B931E48BAF" RetrievedFromCache="false" SecurityPolicyApplied="false">
                <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
                <QueryPlan CachedPlanSize="16" CompileTime="0" CompileCPU="0" CompileMemory="200">
                  <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
                  <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
                  <RelOp AvgRowSize="9" EstimateCPU="2E-06" EstimateIO="0.02" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Insert" NodeId="0" Parallel="false" PhysicalOp="Clustered Index Insert" EstimatedTotalSubtreeCost="0.0200032">
                    <OutputList />
                    <ScalarInsert DMLRequestSort="false">
                      <DefinedValues>
                        <DefinedValue>
                          <ColumnReference Column="Expr1002" />
                          <ScalarOperator ScalarString="CONVERT_IMPLICIT(varchar(50),concat('Row number ',CONVERT_IMPLICIT(varchar(12),[@i2],0)),0)">
                            <Convert DataType="varchar" Length="50" Style="0" Implicit="true">
                              <ScalarOperator>
                                <Intrinsic FunctionName="concat">
                                  <ScalarOperator>
                                    <Const ConstValue="'Row number '" />
                                  </ScalarOperator>
                                  <ScalarOperator>
                                    <Convert DataType="varchar" Length="12" Style="0" Implicit="true">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Column="@i2" />
                                        </Identifier>
                                      </ScalarOperator>
                                    </Convert>
                                  </ScalarOperator>
                                </Intrinsic>
                              </ScalarOperator>
                            </Convert>
                          </ScalarOperator>
                        </DefinedValue>
                        <DefinedValue>
                          <ColumnReference Column="Expr1003" />
                          <ScalarOperator ScalarString="getdate()">
                            <Identifier>
                              <ColumnReference Column="ConstExpr1004">
                                <ScalarOperator>
                                  <Intrinsic FunctionName="getdate" />
                                </ScalarOperator>
                              </ColumnReference>
                            </Identifier>
                          </ScalarOperator>
                        </DefinedValue>
                      </DefinedValues>
                      <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[PK_T]" IndexKind="Clustered" Storage="RowStore" />
                      <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[IX_T_col1]" IndexKind="NonClustered" Storage="RowStore" />
                      <SetPredicate>
                        <ScalarOperator ScalarString="[QuizOne].[dbo].[T].[col1] = RaiseIfNullInsert([@i2]),[QuizOne].[dbo].[T].[col2] = [Expr1002],[QuizOne].[dbo].[T].[col3] = [Expr1003]">
                          <ScalarExpressionList>
                            <ScalarOperator>
                              <MultipleAssign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                                  <ScalarOperator>
                                    <Intrinsic FunctionName="RaiseIfNullInsert">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Column="@i2" />
                                        </Identifier>
                                      </ScalarOperator>
                                    </Intrinsic>
                                  </ScalarOperator>
                                </Assign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                                  <ScalarOperator>
                                    <Identifier>
                                      <ColumnReference Column="Expr1002" />
                                    </Identifier>
                                  </ScalarOperator>
                                </Assign>
                                <Assign>
                                  <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
                                  <ScalarOperator>
                                    <Identifier>
                                      <ColumnReference Column="Expr1003" />
                                    </Identifier>
                                  </ScalarOperator>
                                </Assign>
                              </MultipleAssign>
                            </ScalarOperator>
                          </ScalarExpressionList>
                        </ScalarOperator>
                      </SetPredicate>
                    </ScalarInsert>
                  </RelOp>
                </QueryPlan>
              </StmtSimple>
              <StmtSimple StatementCompId="7" StatementId="7" StatementText=";&#xA;    SET @i2 += 1;&#xA;" StatementType="ASSIGN" RetrievedFromCache="false" />
            </Statements>
          </Then>
        </StmtCond>
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="10" StatementId="8" StatementText="END;&#xA;&#xA;PRINT '*** SELECT * (Expect Clustered Index Scan) ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="11" StatementId="9" StatementText="SET STATISTICS IO ON;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="12" StatementId="10" StatementText="SET STATISTICS TIME ON;&#xA;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="13" StatementEstRows="1000" StatementId="11" StatementOptmLevel="TRIVIAL" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.00734496" StatementText="SELECT * FROM dbo.T" StatementType="SELECT" QueryHash="0x9DD6F80EE91AB69F" QueryPlanHash="0xD2E62ECB0D146488" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan CachedPlanSize="16" CompileTime="0" CompileCPU="0" CompileMemory="160">
            <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
            <RelOp AvgRowSize="48" EstimateCPU="0.001257" EstimateIO="0.00608796" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1000" EstimatedRowsRead="1000" LogicalOp="Clustered Index Scan" NodeId="0" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.00734496" TableCardinality="1000">
              <OutputList>
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
              </OutputList>
              <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                  </DefinedValue>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col2" />
                  </DefinedValue>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col3" />
                  </DefinedValue>
                </DefinedValues>
                <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[PK_T]" IndexKind="Clustered" Storage="RowStore" />
              </IndexScan>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="14" StatementId="12" StatementText=";  -- Clustered Index Scan expected&#xA;&#xA;SET STATISTICS TIME OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="15" StatementId="13" StatementText="SET STATISTICS IO OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;/*****************************************************************************&#xA; STEP 4: CREATE A NON-CLUSTERED INDEX ON col1, THEN SELECT col1&#xA;         (NON-CLUSTERED INDEX SCAN)&#xA;******************************************************************************/&#xA;PRINT '*** STEP 4: Creating Non-Clustered Index on col1 ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtCond StatementCompId="2" StatementEstRows="1" StatementId="2" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="GoodEnoughPlanFound" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.00986596" StatementText="IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_T_col1')" StatementType="COND WITH QUERY" QueryHash="0xB3BFFAC105E40B87" QueryPlanHash="0xBE5082EE335C1A78" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <Condition>
            <QueryPlan NonParallelPlanReason="NonParallelizableIntrinsicFunction" CachedPlanSize="40" CompileTime="3" CompileCPU="3" CompileMemory="960">
              <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
              <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
              <OptimizerStatsUsage>
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[nc]" ModificationCount="373" SamplingPercent="100" LastUpdate="2009-04-13T12:59:17.37" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[_WA_Sys_00000004_00000036]" ModificationCount="36" SamplingPercent="100" LastUpdate="2025-04-15T22:27:11.91" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Statistics="[clst]" ModificationCount="11" SamplingPercent="100" LastUpdate="2025-04-15T19:05:04.19" />
                <StatisticsInfo Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Statistics="[clst]" ModificationCount="373" SamplingPercent="100" LastUpdate="2009-04-13T12:59:17.36" />
              </OptimizerStatsUsage>
              <RelOp AvgRowSize="11" EstimateCPU="1E-07" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Compute Scalar" NodeId="0" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.00986596">
                <OutputList>
                  <ColumnReference Column="Expr1023" />
                </OutputList>
                <ComputeScalar>
                  <DefinedValues>
                    <DefinedValue>
                      <ColumnReference Column="Expr1023" />
                      <ScalarOperator ScalarString="CASE WHEN [Expr1024] THEN (1) ELSE (0) END">
                        <IF>
                          <Condition>
                            <ScalarOperator>
                              <Identifier>
                                <ColumnReference Column="Expr1024" />
                              </Identifier>
                            </ScalarOperator>
                          </Condition>
                          <Then>
                            <ScalarOperator>
                              <Const ConstValue="(1)" />
                            </ScalarOperator>
                          </Then>
                          <Else>
                            <ScalarOperator>
                              <Const ConstValue="(0)" />
                            </ScalarOperator>
                          </Else>
                        </IF>
                      </ScalarOperator>
                    </DefinedValue>
                  </DefinedValues>
                  <RelOp AvgRowSize="9" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Left Semi Join" NodeId="1" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00986586">
                    <OutputList>
                      <ColumnReference Column="Expr1024" />
                    </OutputList>
                    <NestedLoops Optimized="false">
                      <DefinedValues>
                        <DefinedValue>
                          <ColumnReference Column="Expr1024" />
                        </DefinedValue>
                      </DefinedValues>
                      <ProbeColumn>
                        <ColumnReference Column="Expr1024" />
                      </ProbeColumn>
                      <RelOp AvgRowSize="9" EstimateCPU="1.157E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Constant Scan" NodeId="2" Parallel="false" PhysicalOp="Constant Scan" EstimatedTotalSubtreeCost="1.157E-06">
                        <OutputList />
                        <ConstantScan />
                      </RelOp>
                      <RelOp AvgRowSize="9" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimateRowsWithoutRowGoal="1.00109" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00986052">
                        <OutputList />
                        <NestedLoops Optimized="false">
                          <OuterReferences>
                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                          </OuterReferences>
                          <RelOp AvgRowSize="15" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Inner Join" NodeId="5" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.00657126">
                            <OutputList>
                              <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                            </OutputList>
                            <NestedLoops Optimized="false">
                              <OuterReferences>
                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                              </OuterReferences>
                              <RelOp AvgRowSize="15" EstimateCPU="8.8E-07" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Filter" NodeId="6" Parallel="false" PhysicalOp="Filter" EstimatedTotalSubtreeCost="0.00328398">
                                <OutputList>
                                  <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                  <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                </OutputList>
                                <Filter StartupExpression="false">
                                  <RelOp AvgRowSize="15" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Index Seek" NodeId="7" Parallel="false" PhysicalOp="Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="230">
                                    <OutputList>
                                      <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                      <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                    </OutputList>
                                    <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                      <DefinedValues>
                                        <DefinedValue>
                                          <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                        </DefinedValue>
                                        <DefinedValue>
                                          <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                        </DefinedValue>
                                      </DefinedValues>
                                      <Object Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Index="[nc]" Alias="[i]" IndexKind="NonClustered" Storage="RowStore" />
                                      <SeekPredicates>
                                        <SeekPredicateNew>
                                          <SeekKeys>
                                            <Prefix ScanType="EQ">
                                              <RangeColumns>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="name" />
                                              </RangeColumns>
                                              <RangeExpressions>
                                                <ScalarOperator ScalarString="N'IX_T_col1'">
                                                  <Const ConstValue="N'IX_T_col1'" />
                                                </ScalarOperator>
                                              </RangeExpressions>
                                            </Prefix>
                                          </SeekKeys>
                                        </SeekPredicateNew>
                                      </SeekPredicates>
                                    </IndexScan>
                                  </RelOp>
                                  <Predicate>
                                    <ScalarOperator ScalarString="has_access('CO',[QuizOne].[sys].[sysidxstats].[id] as [i].[id])=(1)">
                                      <Compare CompareOp="EQ">
                                        <ScalarOperator>
                                          <Intrinsic FunctionName="has_access">
                                            <ScalarOperator>
                                              <Const ConstValue="'CO'" />
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                              </Identifier>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="" />
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="" />
                                            </ScalarOperator>
                                          </Intrinsic>
                                        </ScalarOperator>
                                        <ScalarOperator>
                                          <Const ConstValue="(1)" />
                                        </ScalarOperator>
                                      </Compare>
                                    </ScalarOperator>
                                  </Predicate>
                                </Filter>
                              </RelOp>
                              <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Clustered Index Seek" NodeId="9" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="230">
                                <OutputList />
                                <IndexScan Lookup="true" Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                  <DefinedValues />
                                  <Object Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Index="[clst]" Alias="[i]" TableReferenceId="-1" IndexKind="Clustered" Storage="RowStore" />
                                  <SeekPredicates>
                                    <SeekPredicateNew>
                                      <SeekKeys>
                                        <Prefix ScanType="EQ">
                                          <RangeColumns>
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                          </RangeColumns>
                                          <RangeExpressions>
                                            <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[id] as [i].[id]">
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                              </Identifier>
                                            </ScalarOperator>
                                            <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[indid] as [i].[indid]">
                                              <Identifier>
                                                <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="indid" />
                                              </Identifier>
                                            </ScalarOperator>
                                          </RangeExpressions>
                                        </Prefix>
                                      </SeekKeys>
                                    </SeekPredicateNew>
                                  </SeekPredicates>
                                  <Predicate>
                                    <ScalarOperator ScalarString="([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(67108864))=(0) AND (([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(1))&lt;(0) OR ([QuizOne].[sys].[sysidxstats].[status] as [i].[status]&amp;(1))&gt;(0))">
                                      <Logical Operation="AND">
                                        <ScalarOperator>
                                          <Compare CompareOp="EQ">
                                            <ScalarOperator>
                                              <Arithmetic Operation="BIT_AND">
                                                <ScalarOperator>
                                                  <Identifier>
                                                    <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                  </Identifier>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(67108864)" />
                                                </ScalarOperator>
                                              </Arithmetic>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Const ConstValue="(0)" />
                                            </ScalarOperator>
                                          </Compare>
                                        </ScalarOperator>
                                        <ScalarOperator>
                                          <Logical Operation="OR">
                                            <ScalarOperator>
                                              <Compare CompareOp="LT">
                                                <ScalarOperator>
                                                  <Arithmetic Operation="BIT_AND">
                                                    <ScalarOperator>
                                                      <Identifier>
                                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                      </Identifier>
                                                    </ScalarOperator>
                                                    <ScalarOperator>
                                                      <Const ConstValue="(1)" />
                                                    </ScalarOperator>
                                                  </Arithmetic>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(0)" />
                                                </ScalarOperator>
                                              </Compare>
                                            </ScalarOperator>
                                            <ScalarOperator>
                                              <Compare CompareOp="GT">
                                                <ScalarOperator>
                                                  <Arithmetic Operation="BIT_AND">
                                                    <ScalarOperator>
                                                      <Identifier>
                                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="status" />
                                                      </Identifier>
                                                    </ScalarOperator>
                                                    <ScalarOperator>
                                                      <Const ConstValue="(1)" />
                                                    </ScalarOperator>
                                                  </Arithmetic>
                                                </ScalarOperator>
                                                <ScalarOperator>
                                                  <Const ConstValue="(0)" />
                                                </ScalarOperator>
                                              </Compare>
                                            </ScalarOperator>
                                          </Logical>
                                        </ScalarOperator>
                                      </Logical>
                                    </ScalarOperator>
                                  </Predicate>
                                </IndexScan>
                              </RelOp>
                            </NestedLoops>
                          </RelOp>
                          <RelOp AvgRowSize="9" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="10" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="2763">
                            <OutputList />
                            <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                              <DefinedValues />
                              <Object Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Index="[clst]" Alias="[obj]" IndexKind="Clustered" Storage="RowStore" />
                              <SeekPredicates>
                                <SeekPredicateNew>
                                  <SeekKeys>
                                    <Prefix ScanType="EQ">
                                      <RangeColumns>
                                        <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysschobjs]" Alias="[obj]" Column="id" />
                                      </RangeColumns>
                                      <RangeExpressions>
                                        <ScalarOperator ScalarString="[QuizOne].[sys].[sysidxstats].[id] as [i].[id]">
                                          <Identifier>
                                            <ColumnReference Database="[QuizOne]" Schema="[sys]" Table="[sysidxstats]" Alias="[i]" Column="id" />
                                          </Identifier>
                                        </ScalarOperator>
                                      </RangeExpressions>
                                    </Prefix>
                                  </SeekKeys>
                                </SeekPredicateNew>
                              </SeekPredicates>
                            </IndexScan>
                          </RelOp>
                        </NestedLoops>
                      </RelOp>
                    </NestedLoops>
                  </RelOp>
                </ComputeScalar>
              </RelOp>
            </QueryPlan>
          </Condition>
          <Then>
            <Statements>
              <StmtSimple StatementCompId="3" StatementId="3" StatementText="&#xA;BEGIN&#xA;    DROP INDEX IX_T_col1 ON dbo.T" StatementType="DROP INDEX" RetrievedFromCache="false" />
            </Statements>
          </Then>
        </StmtCond>
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;CREATE NONCLUSTERED INDEX IX_T_col1 ON dbo.T(col1)" StatementType="CREATE INDEX" RetrievedFromCache="false" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;PRINT '*** SELECT col1 (Expect Non-Clustered Index Scan) ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="2" StatementId="2" StatementText="SET STATISTICS IO ON;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="3" StatementId="3" StatementText="SET STATISTICS TIME ON;&#xA;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="4" StatementEstRows="1000" StatementId="4" StatementOptmLevel="TRIVIAL" CardinalityEstimationModelVersion="160" StatementSubTreeCost="0.00512274" StatementText="SELECT col1 FROM dbo.T" StatementType="SELECT" QueryHash="0x3DB04C4450168C50" QueryPlanHash="0x5D828C251CFD2FEF" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan CachedPlanSize="16" CompileTime="0" CompileCPU="0" CompileMemory="96">
            <MemoryGrantInfo SerialRequiredMemory="0" SerialDesiredMemory="0" GrantedMemory="0" MaxUsedMemory="0" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="139134" EstimatedPagesCached="208701" EstimatedAvailableDegreeOfParallelism="12" MaxCompileMemory="12458520" />
            <RelOp AvgRowSize="11" EstimateCPU="0.001257" EstimateIO="0.00386574" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1000" EstimatedRowsRead="1000" LogicalOp="Index Scan" NodeId="0" Parallel="false" PhysicalOp="Index Scan" EstimatedTotalSubtreeCost="0.00512274" TableCardinality="1000">
              <OutputList>
                <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
              </OutputList>
              <IndexScan Ordered="false" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Database="[QuizOne]" Schema="[dbo]" Table="[T]" Column="col1" />
                  </DefinedValue>
                </DefinedValues>
                <Object Database="[QuizOne]" Schema="[dbo]" Table="[T]" Index="[IX_T_col1]" IndexKind="NonClustered" Storage="RowStore" />
              </IndexScan>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="5" StatementId="5" StatementText=";&#xA;&#xA;SET STATISTICS TIME OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
      <Statements>
        <StmtSimple StatementCompId="6" StatementId="6" StatementText="SET STATISTICS IO OFF;&#xA;" StatementType="SET STATS" RetrievedFromCache="false" />
      </Statements>
    </Batch>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementId="1" StatementText="&#xA;PRINT '*** The Script is Complete!!! here are thee execution plans and times! ***';&#xA;" StatementType="PRINT" RetrievedFromCache="false" />
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>