<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/admin.css" />
    <link rel="stylesheet" href="css/globals.css" />
  </head>
  <body>
    <main>
      <div class="min-h-screen bg-gray-50">
        <div
          class="bg-gradient-to-r from-pink-50 to-orange-50 border-b border-orange-200"
        >
          <div class="max-w-6xl mx-auto px-4 py-8">
            <div class="flex items-center justify-between">
              <div class="flex items-center space-x-6">
                <span
                  data-slot="avatar"
                  class="relative flex size-10 shrink-0 overflow-hidden rounded-full w-20 h-20 ring-4 ring-orange-300"
                  ><img
                    data-slot="avatar-image"
                    class="aspect-square size-full"
                    src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80&amp;h=80&amp;fit=crop&amp;crop=face"
                /></span>
                <div>
                  <h1 class="text-2xl font-medium mb-2">요리마스터</h1>
                  <div class="flex items-center space-x-4 mb-2">
                    <span
                      data-slot="badge"
                      class="inline-flex items-center justify-center rounded-md px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden border-transparent [a&amp;]:hover:bg-primary/90 bg-purple-100 text-purple-600 border-0"
                      >🌳 나무</span
                    ><span class="text-gray-600">가입일: 2023년 3월 15일</span>
                  </div>
                  <div class="flex items-center space-x-2">
                    <span class="text-sm text-gray-600">다음 등급까지</span>
                    <div
                      aria-valuemax="100"
                      aria-valuemin="0"
                      role="progressbar"
                      data-state="indeterminate"
                      data-max="100"
                      data-slot="progress"
                      class="bg-primary/20 relative overflow-hidden rounded-full w-32 h-2"
                    >
                      <div
                        data-state="indeterminate"
                        data-max="100"
                        data-slot="progress-indicator"
                        class="bg-primary h-full w-full flex-1 transition-all"
                        style="transform: translateX(-25%)"
                      ></div>
                    </div>
                    <span class="text-sm text-orange-600">75%</span>
                  </div>
                </div>
              </div>
              <button
                data-slot="button"
                class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive text-primary-foreground h-9 px-4 py-2 has-[&gt;svg]:px-3 bg-orange-500 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-settings w-4 h-4 mr-2"
                  aria-hidden="true"
                >
                  <path
                    d="M9.671 4.136a2.34 2.34 0 0 1 4.659 0 2.34 2.34 0 0 0 3.319 1.915 2.34 2.34 0 0 1 2.33 4.033 2.34 2.34 0 0 0 0 3.831 2.34 2.34 0 0 1-2.33 4.033 2.34 2.34 0 0 0-3.319 1.915 2.34 2.34 0 0 1-4.659 0 2.34 2.34 0 0 0-3.32-1.915 2.34 2.34 0 0 1-2.33-4.033 2.34 2.34 0 0 0 0-3.831A2.34 2.34 0 0 1 6.35 6.051a2.34 2.34 0 0 0 3.319-1.915"
                  ></path>
                  <circle cx="12" cy="12" r="3"></circle></svg
                >설정
              </button>
            </div>
          </div>
        </div>
        <div class="max-w-6xl mx-auto px-4 py-6">
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-orange-50 to-pink-50 border-orange-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-chef-hat w-6 h-6 mx-auto mb-2 text-orange-600"
                  aria-hidden="true"
                >
                  <path
                    d="M17 21a1 1 0 0 0 1-1v-5.35c0-.457.316-.844.727-1.041a4 4 0 0 0-2.134-7.589 5 5 0 0 0-9.186 0 4 4 0 0 0-2.134 7.588c.411.198.727.585.727 1.041V20a1 1 0 0 0 1 1Z"
                  ></path>
                  <path d="M6 17h12"></path>
                </svg>
                <div class="text-2xl font-medium text-orange-600">24</div>
                <div class="text-sm text-gray-600">작성한 레시피</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-pink-50 to-orange-50 border-pink-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-message-square w-6 h-6 mx-auto mb-2 text-pink-600"
                  aria-hidden="true"
                >
                  <path
                    d="M22 17a2 2 0 0 1-2 2H6.828a2 2 0 0 0-1.414.586l-2.202 2.202A.71.71 0 0 1 2 21.286V5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z"
                  ></path>
                </svg>
                <div class="text-2xl font-medium text-pink-600">156</div>
                <div class="text-sm text-gray-600">작성한 댓글</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-red-50 to-pink-50 border-red-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-heart w-6 h-6 mx-auto mb-2 text-red-600"
                  aria-hidden="true"
                >
                  <path
                    d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                  ></path>
                </svg>
                <div class="text-2xl font-medium text-red-600">1847</div>
                <div class="text-sm text-gray-600">받은 좋아요</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-blue-50 to-indigo-50 border-blue-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-eye w-6 h-6 mx-auto mb-2 text-blue-600"
                  aria-hidden="true"
                >
                  <path
                    d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                  ></path>
                  <circle cx="12" cy="12" r="3"></circle>
                </svg>
                <div class="text-2xl font-medium text-blue-600">12,453</div>
                <div class="text-sm text-gray-600">총 조회수</div>
              </div>
            </div>
          </div>
          <div
            dir="ltr"
            data-orientation="horizontal"
            data-slot="tabs"
            class="flex flex-col gap-2 w-full"
          >
            <div
              role="tablist"
              aria-orientation="horizontal"
              data-slot="tabs-list"
              class="bg-muted text-muted-foreground h-9 items-center justify-center rounded-xl p-[3px] grid w-full grid-cols-5 mb-8"
              tabindex="0"
              data-orientation="horizontal"
              style="outline: none"
            >
              <button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r30:-content-profile"
                data-state="inactive"
                id="radix-:r30:-trigger-profile"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                프로필</button
              ><button
                type="button"
                role="tab"
                aria-selected="true"
                aria-controls="radix-:r30:-content-recipes"
                data-state="active"
                id="radix-:r30:-trigger-recipes"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="0"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                내 레시피</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r30:-content-comments"
                data-state="inactive"
                id="radix-:r30:-trigger-comments"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                내 댓글</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r30:-content-liked"
                data-state="inactive"
                id="radix-:r30:-trigger-liked"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                좋아요</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r30:-content-settings"
                data-state="inactive"
                id="radix-:r30:-trigger-settings"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                설정
              </button>
            </div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r30:-trigger-profile"
              id="radix-:r30:-content-profile"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-6"
              style=""
              hidden=""
            ></div>
            <div
              data-state="active"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r30:-trigger-recipes"
              id="radix-:r30:-content-recipes"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
            >
              <div class="flex justify-between items-center">
                <h2 class="text-xl font-medium">작성한 레시피 (4개)</h2>
                <button
                  data-slot="button"
                  class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive text-primary-foreground h-9 px-4 py-2 has-[&gt;svg]:px-3 bg-orange-500 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="lucide lucide-chef-hat w-4 h-4 mr-2"
                    aria-hidden="true"
                  >
                    <path
                      d="M17 21a1 1 0 0 0 1-1v-5.35c0-.457.316-.844.727-1.041a4 4 0 0 0-2.134-7.589 5 5 0 0 0-9.186 0 4 4 0 0 0-2.134 7.588c.411.198.727.585.727 1.041V20a1 1 0 0 0 1 1Z"
                    ></path>
                    <path d="M6 17h12"></path></svg
                  >새 레시피 작성
                </button>
              </div>
              <div class="grid gap-4">
                <div
                  data-slot="card"
                  class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border hover:shadow-md transition-shadow cursor-pointer"
                >
                  <div
                    data-slot="card-content"
                    class="[&amp;:last-child]:pb-6 p-4"
                  >
                    <div class="flex items-center space-x-4">
                      <img
                        src="https://images.unsplash.com/photo-1551218808-94e220e084d2?w=100&amp;h=100&amp;fit=crop"
                        alt="매콤한 김치찌개"
                        class="w-16 h-16 rounded-lg object-cover"
                      />
                      <div class="flex-1">
                        <h3 class="font-medium mb-1">매콤한 김치찌개</h3>
                        <div
                          class="flex items-center space-x-4 text-sm text-gray-600"
                        >
                          <span
                            data-slot="badge"
                            class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                            >한식</span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-eye w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                              ></path>
                              <circle cx="12" cy="12" r="3"></circle></svg
                            ><span>1250</span></span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-heart w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                              ></path></svg
                            ><span>89</span></span
                          ><span>2024-09-10</span>
                        </div>
                      </div>
                      <div class="flex space-x-2">
                        <button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-orange-600 border-orange-300 hover:bg-orange-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-pen-line w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M13 21h8"></path>
                            <path
                              d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"
                            ></path></svg
                          >수정</button
                        ><button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-red-600 border-red-300 hover:bg-red-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-trash2 lucide-trash-2 w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                            <path
                              d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"
                            ></path>
                            <path d="M3 6h18"></path>
                            <path
                              d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                            ></path></svg
                          >삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  data-slot="card"
                  class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border hover:shadow-md transition-shadow cursor-pointer"
                >
                  <div
                    data-slot="card-content"
                    class="[&amp;:last-child]:pb-6 p-4"
                  >
                    <div class="flex items-center space-x-4">
                      <img
                        src="https://images.unsplash.com/photo-1563379091339-03246963d96c?w=100&amp;h=100&amp;fit=crop"
                        alt="이탈리안 파스타"
                        class="w-16 h-16 rounded-lg object-cover"
                      />
                      <div class="flex-1">
                        <h3 class="font-medium mb-1">이탈리안 파스타</h3>
                        <div
                          class="flex items-center space-x-4 text-sm text-gray-600"
                        >
                          <span
                            data-slot="badge"
                            class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                            >양식</span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-eye w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                              ></path>
                              <circle cx="12" cy="12" r="3"></circle></svg
                            ><span>987</span></span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-heart w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                              ></path></svg
                            ><span>67</span></span
                          ><span>2024-09-08</span>
                        </div>
                      </div>
                      <div class="flex space-x-2">
                        <button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-orange-600 border-orange-300 hover:bg-orange-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-pen-line w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M13 21h8"></path>
                            <path
                              d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"
                            ></path></svg
                          >수정</button
                        ><button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-red-600 border-red-300 hover:bg-red-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-trash2 lucide-trash-2 w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                            <path
                              d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"
                            ></path>
                            <path d="M3 6h18"></path>
                            <path
                              d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                            ></path></svg
                          >삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  data-slot="card"
                  class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border hover:shadow-md transition-shadow cursor-pointer"
                >
                  <div
                    data-slot="card-content"
                    class="[&amp;:last-child]:pb-6 p-4"
                  >
                    <div class="flex items-center space-x-4">
                      <img
                        src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=100&amp;h=100&amp;fit=crop"
                        alt="초콜릿 케이크"
                        class="w-16 h-16 rounded-lg object-cover"
                      />
                      <div class="flex-1">
                        <h3 class="font-medium mb-1">초콜릿 케이크</h3>
                        <div
                          class="flex items-center space-x-4 text-sm text-gray-600"
                        >
                          <span
                            data-slot="badge"
                            class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                            >디저트</span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-eye w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                              ></path>
                              <circle cx="12" cy="12" r="3"></circle></svg
                            ><span>756</span></span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-heart w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                              ></path></svg
                            ><span>123</span></span
                          ><span>2024-09-05</span>
                        </div>
                      </div>
                      <div class="flex space-x-2">
                        <button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-orange-600 border-orange-300 hover:bg-orange-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-pen-line w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M13 21h8"></path>
                            <path
                              d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"
                            ></path></svg
                          >수정</button
                        ><button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-red-600 border-red-300 hover:bg-red-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-trash2 lucide-trash-2 w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                            <path
                              d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"
                            ></path>
                            <path d="M3 6h18"></path>
                            <path
                              d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                            ></path></svg
                          >삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  data-slot="card"
                  class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border hover:shadow-md transition-shadow cursor-pointer"
                >
                  <div
                    data-slot="card-content"
                    class="[&amp;:last-child]:pb-6 p-4"
                  >
                    <div class="flex items-center space-x-4">
                      <img
                        src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=100&amp;h=100&amp;fit=crop"
                        alt="중국식 볶음밥"
                        class="w-16 h-16 rounded-lg object-cover"
                      />
                      <div class="flex-1">
                        <h3 class="font-medium mb-1">중국식 볶음밥</h3>
                        <div
                          class="flex items-center space-x-4 text-sm text-gray-600"
                        >
                          <span
                            data-slot="badge"
                            class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                            >중식</span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-eye w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                              ></path>
                              <circle cx="12" cy="12" r="3"></circle></svg
                            ><span>634</span></span
                          ><span class="flex items-center space-x-1"
                            ><svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="24"
                              height="24"
                              viewBox="0 0 24 24"
                              fill="none"
                              stroke="currentColor"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              class="lucide lucide-heart w-3 h-3"
                              aria-hidden="true"
                            >
                              <path
                                d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                              ></path></svg
                            ><span>45</span></span
                          ><span>2024-09-02</span>
                        </div>
                      </div>
                      <div class="flex space-x-2">
                        <button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-orange-600 border-orange-300 hover:bg-orange-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-pen-line w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M13 21h8"></path>
                            <path
                              d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"
                            ></path></svg
                          >수정</button
                        ><button
                          data-slot="button"
                          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive border bg-background hover:text-accent-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50 h-8 rounded-md gap-1.5 px-3 has-[&gt;svg]:px-2.5 text-red-600 border-red-300 hover:bg-red-50"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            class="lucide lucide-trash2 lucide-trash-2 w-3 h-3 mr-1"
                            aria-hidden="true"
                          >
                            <path d="M10 11v6"></path>
                            <path d="M14 11v6"></path>
                            <path
                              d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"
                            ></path>
                            <path d="M3 6h18"></path>
                            <path
                              d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                            ></path></svg
                          >삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r30:-trigger-comments"
              id="radix-:r30:-content-comments"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
              hidden=""
            ></div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r30:-trigger-liked"
              id="radix-:r30:-content-liked"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
              hidden=""
            ></div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r30:-trigger-settings"
              id="radix-:r30:-content-settings"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-6"
              hidden=""
            ></div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>
