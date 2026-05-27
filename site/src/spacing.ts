export type SpacingVariant = "default" | "ultraNarrow";

/** Flip this to compare spacing profiles locally or in preview. */
export const SPACING_VARIANT: SpacingVariant = "ultraNarrow";

export interface SpacingTokens {
  shell: string;
  header: string;
  headerBrand: string;
  headerNav: string;
  headerNavLink: string;
  main: string;
  heroCopy: string;
  heroActions: string;
  ctaButton: string;
  copyButton: string;
  simulatorColumn: string;
  tabButton: string;
  simulatorChrome: string;
  simulatorChromeDots: string;
  simulatorBody: string;
  simulatorCommand: string;
  simulatorPanel: string;
  simulatorPanelTitle: string;
  simulatorPanelSummary: string;
  simulatorPanelSummaryDetail: string;
  simulatorPanelSection: string;
  simulatorPanelSectionHeading: string;
  simulatorPanelSectionList: string;
  simulatorPanelOptions: string;
  simulatorPanelOptionRow: string;
  simulatorPanelFooter: string;
  tuiHeader: string;
  tuiSearch: string;
  tuiList: string;
  tuiRow: string;
  tuiRowInner: string;
  tuiFooter: string;
  tuiFooterActions: string;
  simulatorNote: string;
  features: string;
  featurePanel: string;
  codeSection: string;
  codeHeading: string;
  codeBlock: string;
  footer: string;
  footerLinks: string;
}

const defaultSpacing: SpacingTokens = {
  shell: "min-h-screen flex flex-col relative px-4 md:px-12 py-6 bg-radial from-[#161619] to-[#0c0c0e]",
  header:
    "w-full max-w-6xl mx-auto flex items-center justify-between border-b border-[#2e2e33]/60 pb-4 mb-12 animate-fade-in",
  headerBrand: "flex items-center gap-3",
  headerNav: "flex items-center gap-6",
  headerNavLink: "text-sm font-medium text-[#a1a1aa] hover:text-white transition-colors flex items-center gap-1",
  main: "w-full max-w-6xl mx-auto flex-grow grid grid-cols-1 lg:grid-cols-12 gap-12 items-center mb-16",
  heroCopy: "lg:col-span-6 flex flex-col gap-6 animate-fade-in",
  heroActions: "flex flex-col sm:flex-row items-stretch sm:items-center gap-4 mt-2",
  ctaButton:
    "px-6 py-3 bg-[#06b6d4] hover:bg-[#22d3ee] text-black font-semibold text-center transition-all duration-150 shadow-[0_0_15px_rgba(6,182,212,0.3)]",
  copyButton:
    "flex items-center justify-between gap-4 px-4 py-3 bg-[#1d1d20] hover:bg-[#26262b] border border-[#2e2e33] code-font text-sm text-left transition-colors",
  simulatorColumn: "lg:col-span-6 flex flex-col gap-4 animate-fade-in",
  tabButton: "px-4 py-2 text-sm font-semibold border-b-2 transition-all",
  simulatorChrome: "bg-[#141416] border-b border-[#2e2e33] px-4 py-2 flex items-center justify-between",
  simulatorChromeDots: "flex items-center gap-1.5",
  simulatorBody:
    "p-4 md:p-6 min-h-[360px] flex flex-col justify-start code-font text-xs md:text-sm leading-relaxed overflow-x-auto",
  simulatorCommand: "mb-4 text-[#a1a1aa]",
  simulatorPanel: "border border-[#2e2e33] bg-[#141416] p-4 text-[#f4f4f5] max-w-lg mx-auto",
  simulatorPanelTitle:
    "text-[#06b6d4] font-bold border-b border-[#2e2e33] pb-2 mb-2 flex items-center justify-between",
  simulatorPanelSummary: "mb-3 text-zinc-300",
  simulatorPanelSummaryDetail: "mt-2 text-[#a1a1aa] text-xs leading-normal",
  simulatorPanelSection: "border-t border-[#2e2e33] pt-2 mt-2",
  simulatorPanelSectionHeading: "text-zinc-500 font-bold mb-2",
  simulatorPanelSectionList: "flex flex-col gap-1.5 pl-2",
  simulatorPanelOptions: "border-t border-[#2e2e33] pt-2 mt-2 flex flex-col gap-2",
  simulatorPanelOptionRow: "flex items-start justify-between pl-2",
  simulatorPanelFooter: "border-t border-[#2e2e33] pt-2 mt-3 text-[10px] text-zinc-500 flex justify-between",
  tuiHeader:
    "bg-[#1d1d20]/80 px-3 py-1.5 border-b border-[#2e2e33] flex items-center justify-between text-zinc-400 text-xs",
  tuiSearch: "px-3 py-2 border-b border-[#2e2e33] flex items-center gap-2",
  tuiList: "p-3 min-h-[180px] flex flex-col gap-1.5",
  tuiRow: "flex items-center justify-between py-0.5 px-1 hover:bg-[#1d1d20] group rounded",
  tuiRowInner: "flex items-center gap-2",
  tuiFooter:
    "bg-[#1d1d20]/80 px-3 py-1.5 border-t border-[#2e2e33] flex items-center justify-between text-[10px] text-zinc-500",
  tuiFooterActions: "flex gap-2",
  simulatorNote: "bg-[#141416] border-t border-[#2e2e33] px-4 py-2 text-[10px] text-zinc-500 text-center",
  features: "w-full max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-6 mb-16",
  featurePanel: "p-6 bg-[#141416] border border-[#2e2e33] flex flex-col gap-3",
  codeSection: "w-full max-w-6xl mx-auto border border-[#2e2e33] bg-[#0c0c0e] p-6 mb-16",
  codeHeading: "text-lg font-bold text-white mb-4 code-font",
  codeBlock:
    "bg-[#141416] p-4 text-xs md:text-sm text-zinc-300 overflow-x-auto code-font border border-[#2e2e33] leading-relaxed",
  footer:
    "w-full max-w-6xl mx-auto border-t border-[#2e2e33]/60 pt-6 mt-auto flex flex-col sm:flex-row items-center justify-between text-xs text-[#a1a1aa] gap-4",
  footerLinks: "flex gap-4",
};

const ultraNarrowSpacing: SpacingTokens = {
  shell: "min-h-screen flex flex-col relative px-1 md:px-3 py-1 bg-radial from-[#161619] to-[#0c0c0e]",
  header:
    "w-full max-w-6xl mx-auto flex items-center justify-between border-b border-[#2e2e33]/60 pb-1 mb-3 animate-fade-in",
  headerBrand: "flex items-center gap-1",
  headerNav: "flex items-center gap-2",
  headerNavLink: "text-sm font-medium text-[#a1a1aa] hover:text-white transition-colors flex items-center gap-0.5",
  main: "w-full max-w-6xl mx-auto flex-grow grid grid-cols-1 lg:grid-cols-12 gap-4 items-center mb-6",
  heroCopy: "lg:col-span-6 flex flex-col gap-2 animate-fade-in",
  heroActions: "flex flex-col sm:flex-row items-stretch sm:items-center gap-1.5 mt-0.5",
  ctaButton:
    "px-2.5 py-1.5 bg-[#06b6d4] hover:bg-[#22d3ee] text-black font-semibold text-center transition-all duration-150 shadow-[0_0_15px_rgba(6,182,212,0.3)]",
  copyButton:
    "flex items-center justify-between gap-1.5 px-2 py-1.5 bg-[#1d1d20] hover:bg-[#26262b] border border-[#2e2e33] code-font text-sm text-left transition-colors",
  simulatorColumn: "lg:col-span-6 flex flex-col gap-1.5 animate-fade-in",
  tabButton: "px-2 py-1 text-sm font-semibold border-b-2 transition-all",
  simulatorChrome: "bg-[#141416] border-b border-[#2e2e33] px-1.5 py-0.5 flex items-center justify-between",
  simulatorChromeDots: "flex items-center gap-0.5",
  simulatorBody:
    "p-1.5 md:p-2 min-h-[360px] flex flex-col justify-start code-font text-xs md:text-sm leading-relaxed overflow-x-auto",
  simulatorCommand: "mb-1.5 text-[#a1a1aa]",
  simulatorPanel: "border border-[#2e2e33] bg-[#141416] p-2 text-[#f4f4f5] max-w-lg mx-auto",
  simulatorPanelTitle:
    "text-[#06b6d4] font-bold border-b border-[#2e2e33] pb-0.5 mb-0.5 flex items-center justify-between",
  simulatorPanelSummary: "mb-1 text-zinc-300",
  simulatorPanelSummaryDetail: "mt-0.5 text-[#a1a1aa] text-xs leading-normal",
  simulatorPanelSection: "border-t border-[#2e2e33] pt-1 mt-1",
  simulatorPanelSectionHeading: "text-zinc-500 font-bold mb-0.5",
  simulatorPanelSectionList: "flex flex-col gap-0.5 pl-1",
  simulatorPanelOptions: "border-t border-[#2e2e33] pt-1 mt-1 flex flex-col gap-0.5",
  simulatorPanelOptionRow: "flex items-start justify-between pl-1",
  simulatorPanelFooter: "border-t border-[#2e2e33] pt-1 mt-1.5 text-[10px] text-zinc-500 flex justify-between",
  tuiHeader:
    "bg-[#1d1d20]/80 px-1.5 py-0.5 border-b border-[#2e2e33] flex items-center justify-between text-zinc-400 text-xs",
  tuiSearch: "px-1.5 py-0.5 border-b border-[#2e2e33] flex items-center gap-1",
  tuiList: "p-1.5 min-h-[180px] flex flex-col gap-0.5",
  tuiRow: "flex items-center justify-between py-px px-0.5 hover:bg-[#1d1d20] group rounded",
  tuiRowInner: "flex items-center gap-0.5",
  tuiFooter:
    "bg-[#1d1d20]/80 px-1.5 py-0.5 border-t border-[#2e2e33] flex items-center justify-between text-[10px] text-zinc-500",
  tuiFooterActions: "flex gap-1",
  simulatorNote: "bg-[#141416] border-t border-[#2e2e33] px-1.5 py-0.5 text-[10px] text-zinc-500 text-center",
  features: "w-full max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-2 mb-6",
  featurePanel: "p-2 bg-[#141416] border border-[#2e2e33] flex flex-col gap-1",
  codeSection: "w-full max-w-6xl mx-auto border border-[#2e2e33] bg-[#0c0c0e] p-2 mb-6",
  codeHeading: "text-lg font-bold text-white mb-1.5 code-font",
  codeBlock:
    "bg-[#141416] p-1.5 text-xs md:text-sm text-zinc-300 overflow-x-auto code-font border border-[#2e2e33] leading-relaxed",
  footer:
    "w-full max-w-6xl mx-auto border-t border-[#2e2e33]/60 pt-1.5 mt-auto flex flex-col sm:flex-row items-center justify-between text-xs text-[#a1a1aa] gap-1.5",
  footerLinks: "flex gap-1.5",
};

export const spacingProfiles: Record<SpacingVariant, SpacingTokens> = {
  default: defaultSpacing,
  ultraNarrow: ultraNarrowSpacing,
};

export function useSpacing(variant: SpacingVariant = SPACING_VARIANT): SpacingTokens {
  return spacingProfiles[variant];
}
